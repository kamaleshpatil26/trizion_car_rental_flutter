import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:trizion_car_rental/features/booking/booking_form_page.dart';
import 'package:trizion_car_rental/models/car.dart';

class CarDetailPage extends StatelessWidget {
  final Car car;
  const CarDetailPage({super.key, required this.car});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(car.name),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          /// 🔹 Background Car Image
          SizedBox(
            height: 320,
            width: double.infinity,
            child: Image.network(
              car.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
              const Center(child: Icon(Icons.car_rental, size: 80)),
            ),
          ),

          /// 🔹 Dark overlay for text readability
          Container(
            height: 320,
            color: Colors.black.withOpacity(0.35),
          ),

          /// 🔹 Glass Content
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 260),
                ClipRRect(
                  borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(32)),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.78),
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(32),
                        ),
                      ),
                      child: _buildDetails(context),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// 🔹 Car Name
        Text(
          car.name,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),

        /// 🔹 Category & Seats
        Row(
          children: [
            _infoChip(car.category),
            const SizedBox(width: 10),
            _infoChip('${car.seats} Seats'),
          ],
        ),

        const SizedBox(height: 20),

        /// 🔹 Price Card
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Text(
            '₹${car.pricePerDay.toStringAsFixed(0)} / day',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        const SizedBox(height: 20),

        /// 🔹 Description
        Text(
          car.description,
          style: const TextStyle(
            fontSize: 15,
            height: 1.5,
            color: Colors.black87,
          ),
        ),

        const SizedBox(height: 26),

        /// 🔹 Availability Status
        Row(
          children: [
            Icon(
              car.available ? Icons.check_circle : Icons.cancel,
              color: car.available ? Colors.green : Colors.red,
            ),
            const SizedBox(width: 10),
            Text(
              car.available ? 'Available for booking' : 'Not available currently',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: car.available ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),

        const SizedBox(height: 32),

        /// 🔹 Book Button (Validated)
        SizedBox(
          width: double.infinity,
          height: 54,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor:
              car.available ? Colors.black : Colors.grey.shade400,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            onPressed: car.available
                ? () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BookingFormPage(car: car),
                ),
              );
            }
                : null, // disables button automatically
            child: const Text(
              'Book This Car',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ),

        if (!car.available)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Text(
              'Please check other available cars.',
              style: TextStyle(
                color: Colors.red.shade700,
                fontSize: 13,
              ),
            ),
          ),
      ],
    );
  }

  Widget _infoChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
    );
  }
}
