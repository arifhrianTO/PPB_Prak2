import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  static const _categories = ['Penting', 'Pribadi', 'Kerja'];
  static const _priorities = ['Rendah', 'Sedang', 'Tinggi'];
  static const _colors = [
    AppColors.noteBlue,
    AppColors.noteGreen,
    AppColors.noteYellow,
    AppColors.notePink,
    AppColors.notePurple,
  ];

  int _colorIndex = 0;
  String _priority = 'Sedang';
  String? _category;

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 18, bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: AppColors.textDark,
        ),
      ),
    );
  }

  void _saveNote() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Catatan disimpan (demo UI)'),
        behavior: SnackBarBehavior.floating,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Catatan')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('Judul Catatan'),
              const TextField(
                decoration: InputDecoration(hintText: 'Masukkan judul catatan'),
              ),
              _label('Isi Catatan'),
              const TextField(
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Tulis catatan Anda di sini...',
                ),
              ),
              _label('Kategori'),
              DropdownButtonFormField<String>(
                initialValue: _category,
                icon: const Icon(Icons.keyboard_arrow_down),
                decoration: const InputDecoration(
                  hintText: 'Pilih kategori',
                  prefixIcon: Icon(
                    Icons.folder_open,
                    size: 20,
                    color: AppColors.textGrey,
                  ),
                ),
                items: _categories
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      ),
                    )
                    .toList(),
                onChanged: (value) => setState(() => _category = value),
              ),
              _label('Warna'),
              Row(
                children: List.generate(_colors.length, (index) {
                  final selected = index == _colorIndex;

                  return GestureDetector(
                    onTap: () => setState(() => _colorIndex = index),
                    child: Container(
                      margin: const EdgeInsets.only(right: 16),
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: _colors[index],
                        shape: BoxShape.circle,
                        border: selected
                            ? Border.all(color: AppColors.textDark, width: 2.5)
                            : null,
                      ),
                      child: selected
                          ? const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 18,
                            )
                          : null,
                    ),
                  );
                }),
              ),
              _label('Prioritas'),
              Row(
                children: List.generate(_priorities.length, (index) {
                  final priority = _priorities[index];
                  final active = priority == _priority;

                  return Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _priority = priority),
                      child: Container(
                        margin: EdgeInsets.only(
                          right: index == _priorities.length - 1 ? 0 : 8,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: active ? AppColors.primary : AppColors.field,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          priority,
                          style: TextStyle(
                            fontSize: 13,
                            color: active ? Colors.white : AppColors.textGrey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 28),
              ElevatedButton(onPressed: _saveNote, child: const Text('Simpan')),
            ],
          ),
        ),
      ),
    );
  }
}
