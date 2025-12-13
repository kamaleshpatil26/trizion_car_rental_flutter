import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/booking.dart';
import '../../models/car.dart';
import 'package:uuid/uuid.dart';

final _uuid = Uuid();

class BookingState {
  final List<Booking> bookings;
  BookingState(this.bookings);
}

class BookingNotifier extends StateNotifier<BookingState> {
  BookingNotifier(): super(BookingState([]));

  void addBooking({
    required Car car,
    required String customerName,
    required DateTime start,
    required DateTime end,
    required String location,
  }) {
    final days = end.difference(start).inDays + 1; // inclusive
    final total = days * car.pricePerDay;
    final b = Booking(
      id: _uuid.v4(),
      car: car,
      customerName: customerName,
      startDate: start,
      endDate: end,
      location: location,
      totalPrice: total.toDouble(),
    );
    state = BookingState([...state.bookings, b]);
  }
}

final bookingProvider = StateNotifierProvider<BookingNotifier, BookingState>((ref) {
  return BookingNotifier();
});
