import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/models/chat_models.dart';
import '../bloc/chat_bloc.dart';

class ChatRoomScreen extends StatefulWidget {
  final ChatConversation conversation;

  const ChatRoomScreen({super.key, required this.conversation});

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final _msgController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: isDark ? AppColors.darkCardBg : AppColors.lightCardBg,
        elevation: 0.5,
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: AppColors.neonEmerald.withOpacity(0.2),
              child: Text(
                widget.conversation.partnerName.characters.first,
                style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.neonEmerald),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.conversation.partnerName,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.conversation.bookDeal,
                  style: TextStyle(
                    fontSize: 11,
                    color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // قائمة الرسائل
          Expanded(
            child: BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                if (state is ChatLoadedState) {
                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: state.currentMessages.length,
                    itemBuilder: (context, index) {
                      final msg = state.currentMessages[index];
                      return _buildMessageBubble(msg, isDark);
                    },
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),

          // شريط إرسال الرسائل بالأسفل
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkCardBg : AppColors.lightCardBg,
              border: Border(
                top: BorderSide(
                  color: isDark ? AppColors.darkCardBorder : AppColors.lightCardBorder,
                ),
              ),
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.darkAppBg : AppColors.lightAppBg,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: TextField(
                        controller: _msgController,
                        decoration: const InputDecoration(
                          hintText: 'اكتب رسالتك للاتفاق...',
                          hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    backgroundColor: AppColors.neonEmerald,
                    child: IconButton(
                      icon: const Icon(LucideIcons.sendHorizontal, color: Color(0xFF03140E), size: 18),
                      onPressed: () {
                        final text = _msgController.text.trim();
                        if (text.isNotEmpty) {
                          context.read<ChatBloc>().add(SendMessageEvent(text));
                          _msgController.clear();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage msg, bool isDark) {
    return Align(
      alignment: msg.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        decoration: BoxDecoration(
          color: msg.isMe
              ? AppColors.neonEmerald
              : (isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0)),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(msg.isMe ? 16 : 4),
            bottomRight: Radius.circular(msg.isMe ? 4 : 16),
          ),
        ),
        child: Text(
          msg.text,
          style: TextStyle(
            fontSize: 13,
            color: msg.isMe ? const Color(0xFF03140E) : (isDark ? Colors.white : Colors.black87),
            fontWeight: msg.isMe ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
