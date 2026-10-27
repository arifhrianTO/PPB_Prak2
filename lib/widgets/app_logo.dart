import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Logo CatatanKu: tumpukan sticky notes warna-warni.
class AppLogo extends StatelessWidget {
  final double size;

  const AppLogo({super.key, this.size = 96});

  @override
  Widget build(BuildContext context) {
    final note = size * 0.8;

    Widget sticky(Color color, double angle, {Widget? child}) {
      return Transform.rotate(
        angle: angle,
        child: Container(
          width: note,
          height: note,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(size * 0.08),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(30),
                blurRadius: size * 0.1,
                offset: Offset(1, size * 0.05),
              ),
            ],
          ),
          child: child,
        ),
      );
    }

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          sticky(AppColors.noteBlue, 0.22),
          sticky(AppColors.notePink, -0.16),
          sticky(
            AppColors.noteYellow,
            0.03,
            child: Icon(
              Icons.edit_note_rounded,
              color: AppColors.textDark,
              size: note * 0.6,
            ),
          ),
        ],
      ),
    );
  }
}
