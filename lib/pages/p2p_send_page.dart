import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:winkwink/generated/l10n.dart';

import '../../services/p2p_service.dart';

class P2PSendPage extends StatefulWidget {
  final int fromUserId;
  final int toUserId;
  final File file;

  const P2PSendPage({
    super.key,
    required this.fromUserId,
    required this.toUserId,
    required this.file,
  });

  @override
  State<P2PSendPage> createState() => _P2PSendPageState();
}

class _P2PSendPageState extends State<P2PSendPage> {
  RTCPeerConnection? peer;
  RTCDataChannel? channel;
  late P2PService p2p;
  String? sessionId;

  String status = "";
  bool sending = false;

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
      setState(() => status = l10n.p2pSending);

      final fileSize = await widget.file.length();
      final fileType = widget.file.path.split(".").last;

      final session = await p2p.createSession(
        fromUserId: widget.fromUserId,
        toUserId: widget.toUserId,
        fileSize: fileSize,
        fileType: fileType,
      );

      sessionId = session["session"]["session_id"];

      setState(() => status = l10n.p2pConnectionEstablished);

      peer = await createPeerConnection({
        "iceServers": [
          {"urls": "stun:stun.l.google.com:19302"}
        ]
      });

      channel = await peer!.createDataChannel("file", RTCDataChannelInit());

      peer!.onIceCandidate = (c) {
        if (c.candidate != null && sessionId != null) {
          p2p.sendCandidate(sessionId!, c.toMap());
        }
      };

      final offer = await peer!.createOffer();
      await peer!.setLocalDescription(offer);

      await p2p.sendOffer(sessionId!, offer.toMap());

      setState(() => status = l10n.p2pWaitingAnswer);
      _pollAnswer();
    } catch (e) {
      setState(() => status = "${l10n.p2pSendingError}: $e");
    }
  }

  Future<void> _pollAnswer() async {
    final l10n = S.of(context)!;

    if (sessionId == null) return;

    await Future.doWhile(() async {
      try {
        final session = await p2p.getSession(sessionId!);

        if (session["answer"] != null) {
          await peer!.setRemoteDescription(
            RTCSessionDescription(
              session["answer"]["sdp"],
              session["answer"]["type"],
            ),
          );

          setState(() => status = l10n.p2pSendingInProgress);
          _sendFile();
          return false;
        }
      } catch (e) {
        setState(() => status = "${l10n.p2pSendingError}: $e");
        return false;
      }

      await Future.delayed(const Duration(seconds: 1));
      return true;
    });
  }

  Future<void> _sendFile() async {
    final l10n = S.of(context)!;

    if (channel == null) {
      setState(() => status = l10n.p2pSendingError);
      return;
    }

    setState(() {
      sending = true;
      status = l10n.p2pSendingInProgress;
    });

    try {
      final bytes = await widget.file.readAsBytes();
      const chunkSize = 16 * 1024;

      for (var i = 0; i < bytes.length; i += chunkSize) {
        final end =
            (i + chunkSize < bytes.length) ? i + chunkSize : bytes.length;
        final chunk = bytes.sublist(i, end);

        if (channel!.state != RTCDataChannelState.RTCDataChannelOpen) {
          setState(() => status = l10n.p2pSendingError);
          return;
        }

        channel!.send(RTCDataChannelMessage.fromBinary(chunk));
        await Future.delayed(const Duration(milliseconds: 5));
      }

      channel!.send(RTCDataChannelMessage("EOF"));

      setState(() {
        sending = false;
        status = l10n.p2pSendingCompleted;
      });

      await Future.delayed(const Duration(seconds: 1));
      if (mounted) Navigator.pop(context, true);
    } catch (e) {
      setState(() {
        sending = false;
        status = "${l10n.p2pSendingError}: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.p2pSending),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (sending)
                const CircularProgressIndicator()
              else
                const Icon(Icons.send, size: 48),
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
