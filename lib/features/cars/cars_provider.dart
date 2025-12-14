import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trizion_car_rental/data/mock_data.dart';
import 'package:trizion_car_rental/models/car.dart';

final carsProvider = Provider<List<Car>>((ref) {
  return mockCars;
});
