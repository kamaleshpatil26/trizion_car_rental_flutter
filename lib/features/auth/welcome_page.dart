import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trizion_car_rental/features/auth/auth_provider.dart';


class WelcomePage extends ConsumerWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedIn = ref.watch(authProvider);

    return Scaffold(
      body: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: 'https://images.unsplash.com/photo-1503376780353-7e6692767b70',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            placeholder: (_, __) => const Center(child: CircularProgressIndicator()),
          ),

          Container(color: Colors.black.withOpacity(0.4)),

          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: Container(
                  padding: const EdgeInsets.all(24),
                  color: Colors.white.withOpacity(0.2),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.directions_car, size: 70, color: Colors.white),
                      const SizedBox(height: 16),
                      const Text(
                        'Trizion Car Rental',
                        style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                            context,
                            isLoggedIn ? '/cars' : '/login',
                          );
                        },
                        child: Text(isLoggedIn ? 'Continue' : 'Get Started'),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}


// import 'package:flutter/material.dart';
//
// class WelcomePage extends StatelessWidget {
//   const WelcomePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Background image
//           Image.network(
//             'https://images.unsplash.com/photo-1503376780353-7e6692767b70',
//             height: double.infinity,
//             width: double.infinity,
//             fit: BoxFit.cover,
//           ),
//
//           // Dark overlay
//           Container(color: Colors.black.withOpacity(0.6)),
//
//           // Content
//           Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Icon(Icons.directions_car, color: Colors.white, size: 80),
//                 const SizedBox(height: 16),
//                 const Text(
//                   'Trizion Car Rental',
//                   style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 32),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.white,
//                     foregroundColor: Colors.black,
//                     padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
//                   ),
//                   onPressed: () => Navigator.pushNamed(context, '/login'),
//                   child: const Text('Get Started'),
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
