import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:winkwink/generated/l10n.dart';

import '../../services/p2p_service.dart';
import '../../services/wwgallery_service.dart';
import '../../services/storage_service.dart';

class P2PReceivePage extends StatefulWidget {
  final String sessionId;
  final int userId;

  const P2PReceivePage({
    super.key,
    required this.sessionId,
    required this.userId,
  });

  @override
  State<P2PReceivePage> createState() => _P2PReceivePageState();
}

class _P2PReceivePageState extends State<P2PReceivePage> {
  RTCPeerConnection? peer;
  RTCDataChannel? channel;
  late P2PService p2p;

  List<int> buffer = [];
  String status = "";
  bool receiving = true;

  @override
  void initState() {
    super.initState();
    p2p = P2PService();
    status = "…";
    _start();
  }

  @override
  void dispose() {
    channel?.close();
    peer?.close();
    super.dispose();
  }

  Future<void> _start() async {
    final l10n = S.of(context)!;

    try {
      setState(() => status = l10n.p2pReceivingWaiting);

      peer = await createPeerConnection({
        "iceServers": [
          {"urls": "stun:stun.l.google.com:19302"}
        ]
      });

      // 🔥 Quando arriva il DataChannel
      peer!.onDataChannel = (dc) {
        channel = dc;

        channel!.onMessage = (msg) {
          if (msg.isBinary) {
            buffer.addAll(msg.binary);
          } else if (msg.text == "EOF") {
            _saveFile();
          }
        };
      };

      peer!.onIceCandidate = (c) {
        if (c.candidate != null) {
          p2p.sendCandidate(widget.sessionId, c.toMap());
        }
      };

      final session = await p2p.getSession(widget.sessionId);

      if (session["offer"] == null) {
        setState(() => status = "${l10n.p2pReceivingError}: offer missing");
        return;
      }

      await peer!.setRemoteDescription(
        RTCSessionDescription(
          session["offer"]["sdp"],
          session["offer"]["type"],
        ),
      );

      final answer = await peer!.createAnswer();
      await peer!.setLocalDescription(answer);

      await p2p.sendAnswer(widget.sessionId, answer.toMap());

      setState(() => status = l10n.p2pReceivingEstablished);

      _pollCandidates();
    } catch (e) {
      setState(() => status = "${l10n.p2pReceivingError}: $e");
    }
  }

  Future<void> _pollCandidates() async {
    await Future.doWhile(() async {
      try {
        final session = await p2p.getSession(widget.sessionId);

        if (session["candidates"] != null) {
          for (final c in session["candidates"]) {
            await peer!.addCandidate(
              RTCIceCandidate(
                c["candidate"],
                c["sdpMid"],
                c["sdpMLineIndex"],
              ),
            );
          }
        }
      } catch (_) {}

      await Future.delayed(const Duration(milliseconds: 800));
      return true;
    });
  }

  // ------------------------------------------------------------
  // ⭐ SALVA FILE NELLA WINKGALLERY + INBOX
  // ------------------------------------------------------------
  Future<void> _saveFile() async {
    final l10n = S.of(context)!;

    setState(() {
      receiving = false;
      status = l10n.p2pSavingFile;
    });

    // 🔥 Salva nella WinkGallery (FIX QUI)
    final galleryDir = await WWGalleryService.getGalleryDir();
    final file = File(
      "${galleryDir.path}/received_${DateTime.now().millisecondsSinceEpoch}.bin",
    );

    await file.writeAsBytes(buffer);

    // 🔥 Aggiungi item in Inbox
    await StorageService.saveInboxItem({
      "timestamp": DateTime.now().millisecondsSinceEpoch,
      "type": "p2p_file",
      "qrData": "",
      "path": file.path,
      "fromUserId": widget.userId,
    });

    setState(() => status = l10n.p2pReceivingCompleted);

    await Future.delayed(const Duration(seconds: 1));

    if (mounted) Navigator.pop(context, file);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.p2pReceiving)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              receiving
                  ? const CircularProgressIndicator()
                  : const Icon(Icons.download, size: 48),
              const SizedBox(height: 20),
              Text(
                status,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
