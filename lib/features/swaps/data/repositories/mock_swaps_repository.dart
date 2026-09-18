import '../models/swap_request_model.dart';

class MockSwapsRepository {
  Future<List<SwapRequestModel>> getSwapRequests() async {
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      SwapRequestModel(
        id: 'req_101',
        partnerName: 'كريم محمود',
        offeredBookTitle: 'Deep Work',
        offeredBookCover: 'https://m.media-amazon.com/images/I/71wSsgrOIhL._AC_UF1000,1000_QL80_.jpg',
        requestedBookTitle: 'Clean Code',
        requestedBookCover: 'https://m.media-amazon.com/images/I/71MQRy0Rj4L._AC_UF1000,1000_QL80_.jpg',
        distanceKm: 0.9,
        status: SwapStatus.pending,
        direction: SwapDirection.incoming,
        timestamp: DateTime.now().subtract(const Duration(minutes: 45)),
      ),
      SwapRequestModel(
        id: 'req_102',
        partnerName: 'عمر خالد',
        offeredBookTitle: 'عالم صوفي',
        offeredBookCover: 'https://m.media-amazon.com/images/I/817HaeblezL._AC_UF1000,1000_QL80_.jpg',
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
