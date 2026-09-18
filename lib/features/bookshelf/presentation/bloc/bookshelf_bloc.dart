import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../explore/data/models/book_model.dart';

// Events
abstract class BookshelfEvent extends Equatable {
  const BookshelfEvent();
  @override
  List<Object?> get props => [];
}

class LoadMyBooksEvent extends BookshelfEvent {}

class AddBookToShelfEvent extends BookshelfEvent {
  final BookModel newBook;
  const AddBookToShelfEvent(this.newBook);

  @override
  List<Object?> get props => [newBook];
}

class RemoveBookFromShelfEvent extends BookshelfEvent {
  final String bookId;
  const RemoveBookFromShelfEvent(this.bookId);

  @override
  List<Object?> get props => [bookId];
}

// States
abstract class BookshelfState extends Equatable {
  const BookshelfState();
  @override
  List<Object?> get props => [];
}

class BookshelfLoadingState extends BookshelfState {}

class BookshelfLoadedState extends BookshelfState {
  final List<BookModel> myBooks;
  const BookshelfLoadedState({required this.myBooks});

  @override
  List<Object?> get props => [myBooks];
}

// Bloc
class BookshelfBloc extends Bloc<BookshelfEvent, BookshelfState> {
  // قائمة في الذاكرة (Mock In-Memory List)
  final List<BookModel> _localShelf = [
    const BookModel(
      id: 'my_1',
      isbn: '9789770914830',
      title: 'عالم صوفي',
      author: 'جوستاين غاردر',
      coverUrl:
          'https://m.media-amazon.com/images/I/71YQFjfwc5L._AC_UF894,1000_QL80_.jpg',
      ownerName: 'أنا',
      distanceKm: 0.0,
      swapType: SwapType.permanent,
      condition: 'ممتاز',
      description: 'مدخل روائي شيق لتاريخ الفلسفة، النسخة سليمة تماماً.',
    ),
    const BookModel(
      id: 'my_2',
      isbn: '9780134757599',
      title: 'Refactoring',
      author: 'Martin Fowler',
      coverUrl:
          'https://m.media-amazon.com/images/I/71MQRy0Rj4L._AC_UF1000,1000_QL80_.jpg',
      ownerName: 'أنا',
      distanceKm: 0.0,
      swapType: SwapType.temporary,
      condition: 'كالجديد',
      description: 'كتاب لا غنى عنه لتحسين جودة الكود وبنائه المعماري.',
    ),
  ];

  BookshelfBloc() : super(BookshelfLoadingState()) {
    on<LoadMyBooksEvent>((event, emit) async {
      emit(BookshelfLoadingState());
      await Future.delayed(const Duration(milliseconds: 400));
      emit(BookshelfLoadedState(myBooks: List.from(_localShelf)));
    });

    on<AddBookToShelfEvent>((event, emit) {
      _localShelf.insert(0, event.newBook);
      emit(BookshelfLoadedState(myBooks: List.from(_localShelf)));
    });

    on<RemoveBookFromShelfEvent>((event, emit) {
      _localShelf.removeWhere((book) => book.id == event.bookId);
      emit(BookshelfLoadedState(myBooks: List.from(_localShelf)));
    });
  }
}
