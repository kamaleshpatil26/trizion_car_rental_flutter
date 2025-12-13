import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

final authProvider =
StateNotifierProvider<AuthNotifier, bool>((ref) {
  return AuthNotifier();
});

class AuthNotifier extends StateNotifier<bool> {
  AuthNotifier() : super(false);

  Future<bool> login(String name, String phone) async {
    final prefs = await SharedPreferences.getInstance();
    final users = prefs.getStringList('users') ?? [];

    final exists = users.any((u) {
      final data = jsonDecode(u);
      return data['phone'] == phone;
    });

    if (exists) {
      state = true;
      return true;
    }
    return false;
  }

  Future<void> register(String name, String phone) async {
    final prefs = await SharedPreferences.getInstance();
    final users = prefs.getStringList('users') ?? [];

    users.add(jsonEncode({
      'name': name,
      'phone': phone,
    }));

    await prefs.setStringList('users', users);
    state = true;
  }

  void logout() {
    state = false;
  }
}
