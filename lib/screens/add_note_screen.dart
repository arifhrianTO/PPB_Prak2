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
  static const _colors = AppColors.noteColors;

  final _titleController = TextEditingController();

  int _colorIndex = 0;
  String _priority = 'Sedang';
  String? _category;

  @override
  void initState() {
    super.initState();
    _titleController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 18, bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: AppColors.textDark,
        ),
      ),
    );
  }

  void _saveNote() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Catatan ditempel ke papan (demo UI)'),
        behavior: SnackBarBehavior.floating,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final color = _colors[_colorIndex];
    final title = _titleController.text.trim();

    return Scaffold(
      appBar: AppBar(title: const Text('Tempel Catatan Baru')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Pratinjau sticky note
              Center(
                child: Transform.rotate(
                  angle: -0.035,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: 170,
                    height: 120,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(30),
                          blurRadius: 10,
                          offset: const Offset(2, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title.isEmpty ? 'Judul catatan' : title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: title.isEmpty
                                ? AppColors.textDark.withAlpha(110)
                                : AppColors.textDark,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '${_category ?? 'Kategori'} · $_priority',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: AppColors.darken(color),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              _label('Judul Catatan'),
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  hintText: 'Masukkan judul catatan',
                ),
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
                borderRadius: BorderRadius.circular(14),
                dropdownColor: Colors.white,
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
              _label('Warna Kertas'),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: List.generate(_colors.length, (index) {
                  final selected = index == _colorIndex;

                  return GestureDetector(
                    onTap: () => setState(() => _colorIndex = index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 40,
                      height: 40,
                      transform: Matrix4.rotationZ(selected ? -0.12 : 0),
                      transformAlignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: _colors[index],
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: selected
                              ? AppColors.textDark
                              : Colors.transparent,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(selected ? 40 : 15),
                            blurRadius: 6,
                            offset: const Offset(1, 3),
                          ),
                        ],
                      ),
                      child: selected
                          ? const Icon(
                              Icons.check_rounded,
                              color: AppColors.textDark,
                              size: 20,
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
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: EdgeInsets.only(
                          right: index == _priorities.length - 1 ? 0 : 8,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: active ? AppColors.textDark : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: active
                                ? AppColors.textDark
                                : AppColors.border,
                          ),
                        ),
                        child: Text(
                          priority,
                          style: TextStyle(
                            fontSize: 13,
                            color: active ? Colors.white : AppColors.textDark,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 28),
              ElevatedButton.icon(
                onPressed: _saveNote,
                icon: const Icon(Icons.push_pin_rounded, size: 20),
                label: const Text('Tempel ke Papan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
