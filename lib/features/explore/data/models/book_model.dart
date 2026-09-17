import 'package:equatable/equatable.dart';

enum SwapType { permanent, temporary }

class BookModel extends Equatable {
  final String id;
  final String isbn;
  final String title;
  final String author;
  final String coverUrl;
  final String ownerName;
  final double distanceKm;
  final SwapType swapType;
  final String condition;
  final String description;

  const BookModel({
    required this.id,
    required this.isbn,
    required this.title,
    required this.author,
    required this.coverUrl,
    required this.ownerName,
    required this.distanceKm,
    required this.swapType,
    required this.condition,
    required this.description,
  });

  @override
  List<Object?> get props => [id, isbn, title, author, ownerName];
}
