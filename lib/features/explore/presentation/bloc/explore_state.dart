import 'package:equatable/equatable.dart';
import '../../data/models/book_model.dart';

abstract class ExploreState extends Equatable {
  const ExploreState();

  @override
  List<Object?> get props => [];
}

class ExploreLoadingState extends ExploreState {}

class ExploreLoadedState extends ExploreState {
  final List<BookModel> books;

  const ExploreLoadedState({required this.books});

  @override
  List<Object?> get props => [books];
}

class ExploreErrorState extends ExploreState {
  final String message;

  const ExploreErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
