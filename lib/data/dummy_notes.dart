import 'package:flutter/material.dart';

import '../models/note.dart';
import '../theme/app_theme.dart';

const List<Note> dummyNotes = [
  Note(
    title: 'Ide Aplikasi',
    content: 'Ide untuk membuat aplikasi catatan sederhana dengan fitur kategori, warna, dan prioritas. Aplikasi ini digunakan untuk mencatat ide, rencana, dan hal penting sehari-hari.',
    category: 'Penting',
    priority: 'Sedang',
    date: '19 Oktober 2026',
    time: '09.30',
    color: AppColors.noteYellow,
    icon: Icons.lightbulb,
  ),
  Note(
    title: 'Rencana Mingguan',
    content: 'Menyusun jadwal kegiatan satu minggu ke depan: kuliah, belajar mandiri, olahraga, dan waktu istirahat.',
    category: 'Pribadi',
    priority: 'Rendah',
    date: '18 Oktober 2026',
    time: '20.15',
    color: AppColors.noteGreen,
    icon: Icons.calendar_month,
  ),
  Note(
    title: 'Catatan Kuliah',
    content: 'Ringkasan materi perancangan antarmuka: prinsip konsistensi, hierarki visual, dan navigasi.',
    category: 'Kerja',
    priority: 'Tinggi',
    date: '17 Oktober 2026',
    time: '13.00',
    color: AppColors.notePurple,
    icon: Icons.menu_book,
  ),
  Note(
    title: 'Hal yang Perlu Dibeli',
    content: 'Buku tulis, pulpen, charger, dan kebutuhan harian lainnya.',
    category: 'Pribadi',
    priority: 'Sedang',
    date: '16 Oktober 2026',
    time: '17.45',
    color: AppColors.notePink,
    icon: Icons.shopping_cart,
  ),
  Note(
    title: 'Jurnal Harian',
    content: 'Hari ini cukup produktif. Menyelesaikan desain UI dan belajar Flutter.',
    category: 'Pribadi',
    priority: 'Rendah',
    date: '15 Oktober 2026',
    time: '21.00',
    color: AppColors.noteBlue,
    icon: Icons.favorite,
  ),
];
