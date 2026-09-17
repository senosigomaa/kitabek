import 'package:flutter_bloc/flutter_bloc.dart';
import 'explore_event.dart';
import 'explore_state.dart';
import '../../data/repositories/mock_book_repository.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  final MockBookRepository repository;

  ExploreBloc({required this.repository}) : super(ExploreLoadingState()) {
    on<FetchNearbyBooksEvent>((event, emit) async {
      emit(ExploreLoadingState());
      try {
        final books = await repository.getNearbyBooks();
        emit(ExploreLoadedState(books: books));
      } catch (e) {
        emit(const ExploreErrorState(message: 'تعذر جلب الكتب القريبة'));
      }
    });
  }
}
