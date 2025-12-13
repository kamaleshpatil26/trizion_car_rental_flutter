# 🚗 Trizion Car Rental – Flutter App

A simple multi-screen **Car Rental Booking App (MVP)** built using **Flutter & Riverpod** as part of the Trizion Flutter Developer assignment.

---

## ✨ Features

- Welcome & Login and register name and mob number  (Mock authentication)
- Car list using local mock data
- Car detail page with pricing and specs
- Booking form (name, location, date range)
- Booking confirmation 
- Local persistence using SharedPreferences
- Clean architecture with feature-based folder structure

---

## 🛠️ Tech Stack

- Flutter
- Riverpod (State Management)
- SharedPreferences (Local storage)
- Material & Cupertino UI
- Intl package (Date formatting)

---

## 📂 Folder Structure

```plaintext
lib/
├── data/
│   └── mock_data.dart
├── models/
│   ├── car.dart
│   └── booking.dart
├── features/
│   ├── auth/
│   ├── cars/
│   ├── booking/
│   └── widgets/
├── main.dart
└── app.dart
