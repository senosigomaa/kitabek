import 'package:equatable/equatable.dart';

class ChatMessage extends Equatable {
  final String id;
  final String text;
  final bool isMe;
  final DateTime timestamp;

  const ChatMessage({
    required this.id,
    required this.text,
    required this.isMe,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [id, text, isMe];
}

class ChatConversation extends Equatable {
  final String id;
  final String partnerName;
  final String bookDeal;
  final String lastMessage;
  final DateTime lastMessageTime;
  final int unreadCount;

  const ChatConversation({
    required this.id,
    required this.partnerName,
    required this.bookDeal,
    required this.lastMessage,
    required this.lastMessageTime,
    this.unreadCount = 0,
  });

  @override
  List<Object?> get props => [id, lastMessage, unreadCount];
}
