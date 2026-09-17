import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/chat_models.dart';

// Events
abstract class ChatEvent extends Equatable {
  const ChatEvent();
  @override
  List<Object?> get props => [];
}

class LoadConversationsEvent extends ChatEvent {}

class SendMessageEvent extends ChatEvent {
  final String messageText;
  const SendMessageEvent(this.messageText);

  @override
  List<Object?> get props => [messageText];
}

// States
abstract class ChatState extends Equatable {
  const ChatState();
  @override
  List<Object?> get props => [];
}

class ChatLoadingState extends ChatState {}

class ChatLoadedState extends ChatState {
  final List<ChatConversation> conversations;
  final List<ChatMessage> currentMessages;

  const ChatLoadedState({
    required this.conversations,
    required this.currentMessages,
  });

  @override
  List<Object?> get props => [conversations, currentMessages];
}

// Bloc
class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final List<ChatConversation> _mockConversations = [
    ChatConversation(
      id: 'conv_1',
      partnerName: 'كريم محمود',
      bookDeal: 'مقايضة: Clean Code ⟷ Deep Work',
      lastMessage: 'تمام نتقابل بكرة الساعة 5 عند محطة المترو؟',
      lastMessageTime: DateTime.now().subtract(const Duration(minutes: 15)),
      unreadCount: 2,
    ),
    ChatConversation(
      id: 'conv_2',
      partnerName: 'سارة حسن',
      bookDeal: 'إعارة: ثلاثية غرناطة',
      lastMessage: 'الكتاب معاك بحالة ممتازة، شكراً جداً!',
      lastMessageTime: DateTime.now().subtract(const Duration(hours: 4)),
      unreadCount: 0,
    ),
  ];

  final List<ChatMessage> _mockMessages = [
    ChatMessage(
      id: 'm1',
      text: 'السلام عليكم، شفت طلب المقايضة ووافقت عليه 🤝',
      isMe: false,
      timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
    ),
    ChatMessage(
      id: 'm2',
      text: 'وعليكم السلام، ممتاز جداً! يناسبك نتقابل فين؟',
      isMe: true,
      timestamp: DateTime.now().subtract(const Duration(minutes: 25)),
    ),
    ChatMessage(
      id: 'm3',
      text: 'تمام نتقابل بكرة الساعة 5 عند محطة المترو؟',
      isMe: false,
      timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
    ),
  ];

  ChatBloc() : super(ChatLoadingState()) {
    on<LoadConversationsEvent>((event, emit) async {
      emit(ChatLoadingState());
      await Future.delayed(const Duration(milliseconds: 300));
      emit(ChatLoadedState(
        conversations: List.from(_mockConversations),
        currentMessages: List.from(_mockMessages),
      ));
    });

    on<SendMessageEvent>((event, emit) {
      if (state is ChatLoadedState) {
        final current = state as ChatLoadedState;
        final newMsg = ChatMessage(
          id: 'm_${DateTime.now().millisecondsSinceEpoch}',
          text: event.messageText,
          isMe: true,
          timestamp: DateTime.now(),
        );

        final updatedList = List<ChatMessage>.from(current.currentMessages)..add(newMsg);
        emit(ChatLoadedState(
          conversations: current.conversations,
          currentMessages: updatedList,
        ));
      }
    });
  }
}
