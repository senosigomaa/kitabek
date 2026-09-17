import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/theme/app_colors.dart';
import '../bloc/chat_bloc.dart';
import 'chat_room_screen.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('الرسائل والمحادثات 💬', style: TextStyle(fontWeight: FontWeight.w800)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          if (state is ChatLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ChatLoadedState) {
            if (state.conversations.isEmpty) {
              return const Center(child: Text('لا توجد محادثات جارية حالياً'));
            }

            return ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
              itemCount: state.conversations.length,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final conv = state.conversations[index];

                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => BlocProvider.value(
                          value: context.read<ChatBloc>(),
                          child: ChatRoomScreen(conversation: conv),
                        ),
                      ),
                    );
                  },
                  tileColor: isDark ? AppColors.darkCardBg : AppColors.lightCardBg,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                    side: BorderSide(
                      color: isDark ? AppColors.darkCardBorder : AppColors.lightCardBorder,
                    ),
                  ),
                  leading: CircleAvatar(
                    radius: 24,
                    backgroundColor: AppColors.neonEmerald.withOpacity(0.15),
                    child: Text(
                      conv.partnerName.characters.first,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.neonEmerald,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(conv.partnerName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      if (conv.unreadCount > 0)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.warmAmber,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '${conv.unreadCount}',
                            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ),
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 2),
                      Text(
                        conv.bookDeal,
                        style: const TextStyle(fontSize: 11, color: AppColors.neonEmerald, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        conv.lastMessage,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
                        ),
                      ),
                    ],
                  ),
                  trailing: const Icon(LucideIcons.chevronLeft, size: 18, color: Colors.grey),
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
