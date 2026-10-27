import 'package:flutter/material.dart';

import '../models/note.dart';
import '../theme/app_theme.dart';

class NoteDetailScreen extends StatelessWidget {
  final Note note;

  const NoteDetailScreen({super.key, required this.note});

  void _showDemoMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
    );
  }

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.darken(note.color);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Catatan'),
        actions: [
          IconButton(
            onPressed: () => _showDemoMessage(
              context,
              'Fitur edit tersedia pada versi berikutnya.',
            ),
            tooltip: 'Edit catatan',
            icon: const Icon(Icons.edit_outlined, color: AppColors.textDark),
          ),
          IconButton(
            onPressed: () => _showDemoMessage(
              context,
              'Fitur hapus tersedia pada versi berikutnya.',
            ),
            tooltip: 'Hapus catatan',
            icon: const Icon(Icons.delete_outline, color: AppColors.primary),
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
          child: Transform.rotate(
            angle: -0.015,
            child: Container(
              width: double.infinity,
              constraints: const BoxConstraints(minHeight: 420),
              decoration: BoxDecoration(
                color: note.color,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(35),
                    blurRadius: 16,
                    offset: const Offset(3, 10),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // Selotip
                  Align(
                    alignment: Alignment.topCenter,
                    child: Transform.translate(
                      offset: const Offset(0, -2),
                      child: Container(
                        width: 90,
                        height: 22,
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(150),
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(22, 40, 22, 26),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(120),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(note.icon, color: accent, size: 26),
                            ),
                            const Spacer(),
                            _Tag(text: note.category),
                          ],
                        ),
                        const SizedBox(height: 18),
                        Text(
                          note.title,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            height: 1.2,
                            color: AppColors.textDark,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            _InfoChip(
                              icon: Icons.calendar_today_outlined,
                              text: '${note.date}  ·  ${note.time}',
                            ),
                            _InfoChip(
                              icon: Icons.flag_outlined,
                              text: 'Prioritas ${note.priority}',
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          child: Divider(
                            color: AppColors.textDark.withAlpha(40),
                            thickness: 1,
                          ),
                        ),
                        Text(
                          note.content,
                          style: const TextStyle(
                            fontSize: 15,
                            height: 1.7,
                            color: AppColors.textDark,
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
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final String text;

  const _Tag({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.textDark,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoChip({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(110),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.textDark),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
        ],
      ),
    );
  }
}
