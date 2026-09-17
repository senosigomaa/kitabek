import '../models/swap_request_model.dart';

class MockSwapsRepository {
  Future<List<SwapRequestModel>> getSwapRequests() async {
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      SwapRequestModel(
        id: 'req_101',
        partnerName: 'كريم محمود',
        offeredBookTitle: 'Deep Work',
        offeredBookCover: 'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?auto=format&fit=crop&q=80&w=200',
        requestedBookTitle: 'Clean Code',
        requestedBookCover: 'https://images.unsplash.com/photo-1532012164546-f432f2e3777a?auto=format&fit=crop&q=80&w=200',
        distanceKm: 0.9,
        status: SwapStatus.pending,
        direction: SwapDirection.incoming,
        timestamp: DateTime.now().subtract(const Duration(minutes: 45)),
      ),
      SwapRequestModel(
        id: 'req_102',
        partnerName: 'عمر خالد',
        offeredBookTitle: 'عالم صوفي',
        offeredBookCover: 'https://images.unsplash.com/photo-1544947950-fa07a98d237f?auto=format&fit=crop&q=80&w=200',
        requestedBookTitle: 'Atomic Habits',
        requestedBookCover: 'https://images.unsplash.com/photo-1512820790803-83ca734da794?auto=format&fit=crop&q=80&w=200',
        distanceKm: 1.4,
        status: SwapStatus.accepted,
        direction: SwapDirection.outgoing,
        timestamp: DateTime.now().subtract(const Duration(hours: 3)),
      ),
    ];
  }
}
