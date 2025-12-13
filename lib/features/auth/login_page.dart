import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:trizion_car_rental/features/auth/auth_provider.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();

  bool isRegister = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🔹 Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0F2027), Color(0xFF203A43)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // 🔹 Glass Card
          Center(
            child: Padding(
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
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            isRegister ? 'Register' : 'Login',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),

                          const SizedBox(height: 20),

                          if (isRegister)
                            _glassField(
                              controller: nameCtrl,
                              label: 'Full Name',
                              icon: Icons.person,
                              validator: (v) =>
                              v!.isEmpty ? 'Name required' : null,
                            ),

                          if (isRegister) const SizedBox(height: 14),

                          _glassField(
                            controller: phoneCtrl,
                            label: 'Mobile Number',
                            icon: Icons.phone,
                            keyboardType: TextInputType.phone,
                            validator: (v) =>
                            v!.length != 10 ? 'Enter valid number' : null,
                          ),

                          const SizedBox(height: 24),

                          // 🔹 Action Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                              onPressed: _submit,
                              child: Text(
                                isRegister ? 'Register' : 'Login',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          // 🔹 Toggle
                          GestureDetector(
                            onTap: () {
                              setState(() => isRegister = !isRegister);
                            },
                            child: Text(
                              isRegister
                                  ? 'Already have an account? Login'
                                  : 'New user? Register here',
                              style: const TextStyle(
                                color: Colors.white70,
                                decoration: TextDecoration.underline,
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
        ],
      ),
    );
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    if (isRegister) {
      await ref
          .read(authProvider.notifier)
          .register(nameCtrl.text, phoneCtrl.text);

      Fluttertoast.showToast(msg: 'Registration successful');
      Navigator.pushReplacementNamed(context, '/cars');
    } else {
      final success = await ref
          .read(authProvider.notifier)
          .login(nameCtrl.text, phoneCtrl.text);

      if (success) {
        Fluttertoast.showToast(msg: 'Welcome back!');
        Navigator.pushReplacementNamed(context, '/cars');
      } else {
        Fluttertoast.showToast(
          msg: 'User not found. Please register.',
          backgroundColor: Colors.red,
        );
      }
    }
  }

  Widget _glassField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
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
