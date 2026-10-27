import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/app_logo.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscure = true;

  void _goHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 56),
              const AppLogo(size: 84),
              const SizedBox(height: 20),
              const Text(
                'CatatanKu',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Masuk untuk membuka papan catatanmu',
                style: TextStyle(color: AppColors.textGrey),
              ),
              const SizedBox(height: 36),
              const TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Email',
                  prefixIcon: Icon(
                    Icons.mail_outline,
                    color: AppColors.textGrey,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              TextField(
                obscureText: _obscure,
                decoration: InputDecoration(
                  hintText: 'Password',
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: AppColors.textGrey,
                    size: 20,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscure
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: AppColors.textGrey,
                      size: 20,
                    ),
                    onPressed: () => setState(() => _obscure = !_obscure),
                  ),
                ),
              ),
              const SizedBox(height: 22),
              ElevatedButton(onPressed: _goHome, child: const Text('Masuk')),
              const SizedBox(height: 18),
              const Row(
                children: [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      'atau',
                      style: TextStyle(color: AppColors.textGrey),
                    ),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 18),
              OutlinedButton(
                onPressed: _goHome,
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: AppColors.border),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'G',
                      style: TextStyle(
                        color: Color(0xFFDB4437),
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Masuk dengan Google',
                      style: TextStyle(color: AppColors.textDark),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
