import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:winkwink/generated/l10n.dart';

import '../../widgets/winkwink_scaffold.dart';
import '../../providers/color_provider.dart';
import '../../services/messages_service.dart';

class ChatPage extends StatefulWidget {
  final int userId;
  final int otherId;
  final String? name;

  const ChatPage({
    super.key,
    required this.userId,
    required this.otherId,
    this.name,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<Map<String, dynamic>> messages = [];
  final controller = TextEditingController();
  final scrollController = ScrollController();

  Future<void> loadMessages() async {
    final list = await MessagesService.getMessages(
      widget.userId,
      widget.otherId,
    );

    // ⭐ Normalizziamo i messaggi per evitare crash
    final normalized = list.map<Map<String, dynamic>>((msg) {
      return {
        "sender_id": msg["sender_id"] ?? msg["senderId"] ?? -1,
        "receiver_id": msg["receiver_id"] ?? msg["receiverId"] ?? -1,
        "content": msg["content"] ?? "",
      };
    }).toList();

    setState(() => messages = normalized);

    Future.delayed(const Duration(milliseconds: 100), () {
      if (scrollController.hasClients) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      }
    });
  }

  Future<void> sendMessage() async {
    if (controller.text.isEmpty) return;

    await MessagesService.sendMessage(
      senderId: widget.userId,
      receiverId: widget.otherId,
      content: controller.text,
    );

    controller.clear();
    loadMessages();
  }

  // ------------------------------------------------------------
  // ⭐ INVIA FILE P2P
  // ------------------------------------------------------------
  void _sendFileP2P() {
    Navigator.pushNamed(
      context,
      "/encrypt",
      arguments: {
        "mode": "p2p",
        "fromUserId": widget.userId,
        "toUserId": widget.otherId,
      },
    );
  }

  @override
  void initState() {
    super.initState();
    loadMessages();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ColorProvider>(context);
    final l10n = S.of(context)!;

    final displayName = widget.name ?? "Utente ${widget.otherId}";

    return WinkWinkScaffold(
      showColorSelector: false,
      userId: widget.userId,
      child: Column(
        children: [
          const SizedBox(height: 12),

          // ⭐ TITOLO
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              l10n.chatWith(displayName),
              style: TextStyle(
                color: theme.text,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 12),

          // ⭐ LISTA MESSAGGI
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: messages.length,
              itemBuilder: (context, i) {
                final msg = messages[i];

                // ⭐ Sicuro: mai null
                final senderId = msg["sender_id"] ?? -1;
                final content = msg["content"] ?? "";

                final isMe = senderId == widget.userId;

                return Align(
                  alignment:
                      isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    margin:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                    decoration: BoxDecoration(
                      color: isMe
                          ? theme.primary.withOpacity(0.9)
                          : theme.background.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: theme.text.withOpacity(0.3),
                      ),
                    ),
                    child: Text(
                      content,
                      style: TextStyle(
                        color: isMe ? Colors.white : theme.text,
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // ⭐ INPUT + INVIO + ALLEGA FILE
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: theme.background.withOpacity(0.4),
              border: Border(
                top: BorderSide(color: theme.text.withOpacity(0.3)),
              ),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.attach_file, color: theme.primary, size: 28),
                  onPressed: _sendFileP2P,
                ),
                Expanded(
                  child: TextField(
                    controller: controller,
                    style: TextStyle(color: theme.text),
                    decoration: InputDecoration(
                      hintText: l10n.chatPlaceholder,
                      hintStyle: TextStyle(
                        color: theme.text.withOpacity(0.5),
                      ),
                      filled: true,
                      fillColor: theme.background.withOpacity(0.2),
                      contentPadding: const EdgeInsets.all(12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: theme.text.withOpacity(0.3),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.send, color: theme.primary, size: 28),
                  onPressed: sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
