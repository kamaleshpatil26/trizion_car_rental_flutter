import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:trizion_car_rental/features/booking/booking_confirmation_page.dart';
import 'package:trizion_car_rental/features/booking/booking_provider.dart';
import 'package:trizion_car_rental/models/car.dart';

class BookingFormPage extends ConsumerStatefulWidget {
  final Car car;
  const BookingFormPage({required this.car, super.key});

  @override
  ConsumerState<BookingFormPage> createState() => _BookingFormPageState();
}

class _BookingFormPageState extends ConsumerState<BookingFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _locationCtrl = TextEditingController();
  DateTimeRange? _range;

  String format(DateTime d) => DateFormat('dd MMM yyyy').format(d);

  @override
  void dispose() {
    _nameCtrl.dispose();
    _locationCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final car = widget.car;

    return Scaffold(
      body: Stack(
        children: [
          // 🔹 Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF141E30),
                  Color(0xFF243B55),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // 🔹 Glass Card
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.25),
                        ),
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 🔹 Header
                            Text(
                              'Book ${car.name}',
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),

                            const SizedBox(height: 20),

                            _glassField(
                              controller: _nameCtrl,
                              label: 'Full Name',
                              icon: Icons.person,
                              validator: (v) =>
                              (v == null || v.trim().isEmpty)
                                  ? 'Enter name'
                                  : null,
                            ),

                            const SizedBox(height: 14),

                            _glassField(
                              controller: _locationCtrl,
                              label: 'Pickup Location',
                              icon: Icons.location_on,
                              validator: (v) =>
                              (v == null || v.trim().isEmpty)
                                  ? 'Enter location'
                                  : null,
                            ),

                            const SizedBox(height: 14),

                            // 🔹 Date Picker
                            InkWell(
                              borderRadius: BorderRadius.circular(16),
                              onTap: () async {
                                final now = DateTime.now();
                                final dt = await showDateRangePicker(
                                  context: context,
                                  firstDate: now,
                                  lastDate:
                                  now.add(const Duration(days: 365)),
                                );
                                if (dt != null) {
                                  setState(() => _range = dt);
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 14),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Colors.white.withOpacity(0.2),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.calendar_today,
                                        color: Colors.white70),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        _range == null
                                            ? 'Select Booking Dates'
                                            : '${format(_range!.start)} → ${format(_range!.end)}',
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(height: 24),

                            // 🔹 Confirm Button
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding:
                                  const EdgeInsets.symmetric(vertical: 16),
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                ),
                                onPressed: _submit,
                                child: const Text(
                                  'Confirm Booking',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate() && _range != null) {
      ref.read(bookingProvider.notifier).addBooking(
        car: widget.car,
        customerName: _nameCtrl.text.trim(),
        start: _range!.start,
        end: _range!.end,
        location: _locationCtrl.text.trim(),
      );

      final newBooking =
          ref.read(bookingProvider).bookings.last;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) =>
              BookingConfirmationPage(booking: newBooking),
        ),
      );
    } else if (_range == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pick booking dates')),
      );
    }
  }

  Widget _glassField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.white70),
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.white.withOpacity(0.2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
