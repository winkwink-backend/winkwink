import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:winkwink/models/ww_contact.dart';
import 'package:winkwink/services/p2p_service.dart';
import 'package:winkwink/services/storage_service.dart';
import 'package:winkwink/services/wwgallery_service.dart';

class WebRTCManager {
  WebRTCManager._();
  static final WebRTCManager instance = WebRTCManager._();

  RTCPeerConnection? _peer;
  RTCDataChannel? _channel;
  final P2PService _p2p = P2PService();

  StreamController<double> _progress = StreamController.broadcast();
  Stream<double> get progress => _progress.stream;

  StreamController<File> _receivedFiles = StreamController.broadcast();
  Stream<File> get receivedFiles => _receivedFiles.stream;

  // ============================================================
  // ⭐ INVIO FILE
  // ============================================================
  Future<void> sendFile({
    required WWContact contact,
    required File file,
    required String fileType,
  }) async {
    final fromUserId = await StorageService.getUserId();
    final toUserId = int.parse(contact.userId);

    final fileSize = await file.length();

    // 1) CREA SESSIONE
    final session = await _p2p.createSession(
      fromUserId: fromUserId!,
      toUserId: toUserId,
      fileSize: fileSize,
      fileType: fileType,
    );

    final sessionId = session["session"]["session_id"];

    // 2) CREA PEER
    _peer = await createPeerConnection({
      "iceServers": [
        {"urls": "stun:stun.l.google.com:19302"}
      ]
    });

    // 3) DATA CHANNEL
    _channel = await _peer!.createDataChannel("file", RTCDataChannelInit());

    // 4) ICE
    _peer!.onIceCandidate = (c) {
      if (c.candidate != null) {
        _p2p.sendCandidate(sessionId, c.toMap());
      }
    };

    // 5) OFFER
    final offer = await _peer!.createOffer();
    await _peer!.setLocalDescription(offer);
    await _p2p.sendOffer(sessionId, offer.toMap());

    // 6) ASPETTA ANSWER
    await _waitForAnswer(sessionId);

    // 7) INVIA FILE
    await _sendFileChunks(file);
  }

  Future<void> _waitForAnswer(String sessionId) async {
    await Future.doWhile(() async {
      final session = await _p2p.getSession(sessionId);

      if (session["answer"] != null) {
        await _peer!.setRemoteDescription(
          RTCSessionDescription(
            session["answer"]["sdp"],
            session["answer"]["type"],
          ),
        );
        return false;
      }

      await Future.delayed(const Duration(milliseconds: 800));
      return true;
    });
  }

  Future<void> _sendFileChunks(File file) async {
    final bytes = await file.readAsBytes();
    const chunkSize = 16 * 1024;

    for (var i = 0; i < bytes.length; i += chunkSize) {
      final end = (i + chunkSize < bytes.length) ? i + chunkSize : bytes.length;
      final chunk = bytes.sublist(i, end);

      if (_channel!.state != RTCDataChannelState.RTCDataChannelOpen) {
        throw Exception("DataChannel chiuso");
      }

      _channel!.send(RTCDataChannelMessage.fromBinary(chunk));

      _progress.add(i / bytes.length);

      await Future.delayed(const Duration(milliseconds: 5));
    }

    _channel!.send(RTCDataChannelMessage("EOF"));
    _progress.add(1.0);
  }

  // ============================================================
  // ⭐ RICEZIONE FILE
  // ============================================================
  Future<void> listenForIncomingSession({
    required String sessionId,
  }) async {
    List<int> buffer = [];

    _peer = await createPeerConnection({
      "iceServers": [
        {"urls": "stun:stun.l.google.com:19302"}
      ]
    });

    _peer!.onDataChannel = (dc) {
      _channel = dc;

      _channel!.onMessage = (msg) async {
        if (msg.isBinary) {
          buffer.addAll(msg.binary);
        } else if (msg.text == "EOF") {
          final file = await _saveReceivedFile(buffer);
          _receivedFiles.add(file);
        }
      };
    };

    _peer!.onIceCandidate = (c) {
      if (c.candidate != null) {
        _p2p.sendCandidate(sessionId, c.toMap());
      }
    };

    final session = await _p2p.getSession(sessionId);

    if (session["offer"] == null) {
      throw Exception("Offer mancante");
    }

    await _peer!.setRemoteDescription(
      RTCSessionDescription(
        session["offer"]["sdp"],
        session["offer"]["type"],
      ),
    );

    final answer = await _peer!.createAnswer();
    await _peer!.setLocalDescription(answer);
    await _p2p.sendAnswer(sessionId, answer.toMap());

    _pollCandidates(sessionId);
  }

  Future<void> _pollCandidates(String sessionId) async {
    await Future.doWhile(() async {
      final session = await _p2p.getSession(sessionId);

      if (session["candidates"] != null) {
        for (final c in session["candidates"]) {
          await _peer!.addCandidate(
            RTCIceCandidate(
              c["candidate"],
              c["sdpMid"],
              c["sdpMLineIndex"],
            ),
          );
        }
      }

      await Future.delayed(const Duration(milliseconds: 800));
      return true;
    });
  }

  Future<File> _saveReceivedFile(List<int> buffer) async {
    final dir = await WWGalleryService.getGalleryDir(); // ✔ FIX QUI

    final file = File(
      "${dir.path}/received_${DateTime.now().millisecondsSinceEpoch}.bin",
    );

    await file.writeAsBytes(buffer);

    return file;
  }
}
