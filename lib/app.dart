import 'package:flutter/material.dart';
import 'package:trizion_car_rental/features/auth/welcome_page.dart';

import 'features/auth/login_page.dart';
import 'features/cars/car_list_page.dart';
import 'features/cars/car_detail_page.dart';
import 'features/booking/booking_form_page.dart';
import 'features/booking/booking_confirmation_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trizion Car Rental',

      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      // 🔥 The login page will show first
      initialRoute: '/',

      routes: {

        '/': (_) => const WelcomePage(),
        '/login': (_) => const LoginPage(),
        '/cars': (_) => const CarListPage(),

        // '/': (context) => const LoginPage(),
        //
        // // Car list page
        // '/cars': (context) => const CarListPage(),

        // Navigate with arguments → so not registered in routes table
      },

      debugShowCheckedModeBanner: false,
    );
  }
}
