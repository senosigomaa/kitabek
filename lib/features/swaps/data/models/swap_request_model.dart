import 'package:equatable/equatable.dart';

enum SwapStatus { pending, accepted, rejected, completed }
enum SwapDirection { incoming, outgoing }

class SwapRequestModel extends Equatable {
  final String id;
  final String partnerName;
  final String offeredBookTitle;
  final String offeredBookCover;
  final String requestedBookTitle;
  final String requestedBookCover;
  final double distanceKm;
  final SwapStatus status;
  final SwapDirection direction;
  final DateTime timestamp;

  const SwapRequestModel({
    required this.id,
    required this.partnerName,
    required this.offeredBookTitle,
    required this.offeredBookCover,
    required this.requestedBookTitle,
    required this.requestedBookCover,
    required this.distanceKm,
    required this.status,
    required this.direction,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [id, status];
}
