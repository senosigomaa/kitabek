import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/swap_request_model.dart';
import '../../data/repositories/mock_swaps_repository.dart';

// Events
abstract class SwapsEvent extends Equatable {
  const SwapsEvent();
  @override
  List<Object?> get props => [];
}

class FetchSwapsEvent extends SwapsEvent {}

class UpdateSwapStatusEvent extends SwapsEvent {
  final String id;
  final SwapStatus newStatus;

  const UpdateSwapStatusEvent({required this.id, required this.newStatus});

  @override
  List<Object?> get props => [id, newStatus];
}

// States
abstract class SwapsState extends Equatable {
  const SwapsState();
  @override
  List<Object?> get props => [];
}

class SwapsLoadingState extends SwapsState {}

class SwapsLoadedState extends SwapsState {
  final List<SwapRequestModel> requests;
  const SwapsLoadedState({required this.requests});

  @override
  List<Object?> get props => [requests];
}

// Bloc
class SwapsBloc extends Bloc<SwapsEvent, SwapsState> {
  final MockSwapsRepository repository;

  SwapsBloc({required this.repository}) : super(SwapsLoadingState()) {
    on<FetchSwapsEvent>((event, emit) async {
      emit(SwapsLoadingState());
      final requests = await repository.getSwapRequests();
      emit(SwapsLoadedState(requests: requests));
    });

    on<UpdateSwapStatusEvent>((event, emit) {
      if (state is SwapsLoadedState) {
        final currentRequests = (state as SwapsLoadedState).requests;
        final updated = currentRequests.map((req) {
          if (req.id == event.id) {
            return SwapRequestModel(
              id: req.id,
              partnerName: req.partnerName,
              offeredBookTitle: req.offeredBookTitle,
              offeredBookCover: req.offeredBookCover,
              requestedBookTitle: req.requestedBookTitle,
              requestedBookCover: req.requestedBookCover,
              distanceKm: req.distanceKm,
              status: event.newStatus,
              direction: req.direction,
              timestamp: req.timestamp,
            );
          }
          return req;
        }).toList();
        emit(SwapsLoadedState(requests: updated));
      }
    });
  }
}
