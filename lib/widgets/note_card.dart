import 'package:flutter/material.dart';

import '../models/note.dart';
import '../theme/app_theme.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  final VoidCallback onTap;

  const NoteCard({super.key, required this.note, required this.onTap});

  /// Sudut kemiringan deterministik (±~2.3°) agar stabil saat rebuild.
  double get _angle => ((note.title.hashCode % 5) - 2) * 0.02;

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.darken(note.color);

    return Transform.rotate(
      angle: _angle,
      child: Container(
        decoration: BoxDecoration(
          color: note.color,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(30),
              blurRadius: 10,
              offset: const Offset(2, 6),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(6),
            onTap: onTap,
            child: Stack(
              children: [
                // "Selotip" di bagian atas kartu
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: 46,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(140),
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(3),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(14, 22, 14, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(note.icon, color: accent, size: 22),
                          const Spacer(),
                          _PriorityDot(priority: note.priority),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        note.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          height: 1.2,
                          color: AppColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Expanded(
                        child: Text(
                          note.content,
                          overflow: TextOverflow.fade,
                          style: TextStyle(
                            fontSize: 12,
                            height: 1.35,
                            color: AppColors.textDark.withAlpha(180),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        note.date,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: accent,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PriorityDot extends StatelessWidget {
  final String priority;

  const _PriorityDot({required this.priority});

  @override
  Widget build(BuildContext context) {
    final count = switch (priority) {
      'Tinggi' => 3,
      'Sedang' => 2,
      _ => 1,
    };

    return Tooltip(
      message: 'Prioritas $priority',
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(3, (index) {
          return Container(
            margin: const EdgeInsets.only(left: 3),
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: index < count
                  ? AppColors.textDark
                  : AppColors.textDark.withAlpha(40),
            ),
          );
        }),
      ),
    );
  }
}
