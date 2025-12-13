import 'package:flutter/material.dart';
import 'package:trizion_car_rental/features/booking/booking_form_page.dart';
import 'package:trizion_car_rental/models/car.dart';


class CarDetailPage extends StatelessWidget {
  final Car car;
  const CarDetailPage({required this.car, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(car.name)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(car.imageUrl, width: double.infinity, height: 220, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(car.name, style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Text('${car.category} • ${car.seats} seats'),
                  const SizedBox(height: 8),
                  Text('₹${car.pricePerDay.toStringAsFixed(0)} / day', style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Text(car.description),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 48),
                    ),
                    onPressed: car.available ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => BookingFormPage(car: car)),
                      );
                    } : null,
                    child: const Text('Book this car'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
