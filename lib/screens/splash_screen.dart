import 'dart:async';

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/app_logo.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Sticky notes dekoratif di pojok
          const _DecorNote(
            top: 60,
            left: -20,
            color: AppColors.notePink,
            angle: -0.3,
          ),
          const _DecorNote(
            top: 140,
            right: -24,
            color: AppColors.noteGreen,
            angle: 0.25,
          ),
          const _DecorNote(
            bottom: 120,
            left: 24,
            color: AppColors.noteBlue,
            angle: 0.18,
            size: 56,
          ),
          const _DecorNote(
            bottom: 60,
            right: 30,
            color: AppColors.notePurple,
            angle: -0.2,
            size: 64,
          ),
          SafeArea(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const AppLogo(size: 110),
                  const SizedBox(height: 28),
                  const Text(
                    'CatatanKu',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 48),
                    child: Text(
                      'Tempel setiap ide, rencana, dan momen berharga di satu papan.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColors.textGrey, fontSize: 14),
                    ),
                  ),
                  const SizedBox(height: 48),
                  SizedBox(
                    width: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: const LinearProgressIndicator(
                        minHeight: 6,
                        color: AppColors.primary,
                        backgroundColor: AppColors.border,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DecorNote extends StatelessWidget {
  final double? top;
  final double? left;
  final double? right;
  final double? bottom;
  final Color color;
  final double angle;
  final double size;

  const _DecorNote({
    this.top,
    this.left,
    this.right,
    this.bottom,
    required this.color,
    required this.angle,
    this.size = 80,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: Transform.rotate(
        angle: angle,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: color.withAlpha(170),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ),
    );
  }
}
