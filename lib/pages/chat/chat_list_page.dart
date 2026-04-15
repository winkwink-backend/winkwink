import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:winkwink/generated/l10n.dart';

import '../../widgets/winkwink_scaffold.dart';
import '../../providers/color_provider.dart';
import '../../services/messages_service.dart';
import '../../routes.dart';

class ChatListPage extends StatefulWidget {
  final int userId;

  const ChatListPage({
    super.key,
    required this.userId,
  });

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  late Future<List<Map<String, dynamic>>> conversations;

  @override
  void initState() {
    super.initState();
    conversations = MessagesService.getConversations(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ColorProvider>(context);
    final l10n = S.of(context)!;

    return WinkWinkScaffold(
      showColorSelector: false,
      userId: widget.userId,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              l10n.chatListTitle,
              style: TextStyle(
                color: theme.text,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: FutureBuilder(
              future: conversations,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  );
                }

                final conv = snapshot.data!;

                if (conv.isEmpty) {
                  return Center(
                    child: Text(
                      l10n.chatListEmpty,
                      style: TextStyle(
                        color: theme.text,
                        fontSize: 18,
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: conv.length,
                  itemBuilder: (context, i) {
                    final c = conv[i];

                    // ⭐ Normalizzazione sicura
                    final otherId =
                        c["chat_with"] ?? c["chatWith"] ?? c["other_id"] ?? -1;

                    final lastMessage = c["last_message"] ?? {};

                    final senderId =
                        lastMessage["sender_id"] ?? lastMessage["senderId"];

                    final type = lastMessage["type"] ?? "";
                    final content = lastMessage["content"] ?? "";

                    final isFile = type == "file_transfer_request";
                    final unread = c["unread"] ?? false;

                    // ⭐ Anteprima sicura
                    String preview;
                    if (isFile) {
                      preview = senderId == widget.userId
                          ? l10n.chatListFileSent
                          : l10n.chatListFileReceived;
                    } else {
                      preview = content;
                    }

                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        color: theme.background.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: theme.text.withOpacity(0.3),
                        ),
                      ),
                      child: ListTile(
                        leading: Stack(
                          children: [
                            CircleAvatar(
                              backgroundColor: theme.primary,
                              child: Icon(
                                isFile ? Icons.file_present : Icons.person,
                                color: Colors.white,
                              ),
                            ),
                            if (unread && isFile)
                              Positioned(
                                right: 0,
                                top: 0,
                                child: Container(
                                  width: 12,
                                  height: 12,
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        title: Text(
                          l10n.chatListUser(otherId.toString()),
                          style: TextStyle(
                            color: theme.text,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          preview,
                          style: TextStyle(
                            color: theme.text.withOpacity(0.7),
                            fontSize: 14,
                          ),
                        ),
                        trailing: Icon(Icons.chevron_right, color: theme.text),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.chat,
                            arguments: {
                              "userId": widget.userId,
                              "otherId": otherId,
                              "name": l10n.chatListUser(otherId.toString()),
                            },
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
