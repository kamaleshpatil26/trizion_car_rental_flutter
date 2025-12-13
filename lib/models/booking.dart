import 'car.dart';

class Booking {
  final String id;
  final Car car;
  final DateTime startDate;
  final DateTime endDate;
  final String location;
  final String customerName;
  final double totalPrice;

  Booking({
    required this.id,
    required this.car,
    required this.startDate,
    required this.endDate,
    required this.location,
    required this.customerName,
    required this.totalPrice,
  });

  // 🔹 Convert Booking → Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'car': car.toJson(), // nested object
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'location': location,
      'customerName': customerName,
      'totalPrice': totalPrice,
    };
  }

  // 🔹 Convert Map (JSON) → Booking
  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      car: Car.fromJson(json['car']),
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      location: json['location'],
      customerName: json['customerName'],
      totalPrice: (json['totalPrice'] as num).toDouble(),
    );
  }
}


// import 'package:flutter/foundation.dart';
// import '../models/car.dart';
//
// class Booking {
//   final String id;
//   final Car car;
//   final String customerName;
//   final DateTime startDate;
//   final DateTime endDate;
//   final String location;
//   final double totalPrice;
//
//   Booking({
//     required this.id,
//     required this.car,
//     required this.customerName,
//     required this.startDate,
//     required this.endDate,
//     required this.location,
//     required this.totalPrice,
//   });
// }
