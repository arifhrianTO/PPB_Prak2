import 'package:flutter/material.dart';

import '../data/dummy_notes.dart';
import '../models/note.dart';
import '../theme/app_theme.dart';
import '../widgets/note_card.dart';
import 'add_note_screen.dart';
import 'note_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const _categories = ['Semua', 'Penting', 'Pribadi', 'Kerja'];
  static const _categoryColors = {
    'Semua': AppColors.textDark,
    'Penting': AppColors.noteYellow,
    'Pribadi': AppColors.notePink,
    'Kerja': AppColors.noteBlue,
  };

  String _selectedCategory = 'Semua';
  String _query = '';
  int _navIndex = 0;

  List<Note> get _filteredNotes {
    final query = _query.trim().toLowerCase();

    return dummyNotes.where((note) {
      final matchesCategory =
          _selectedCategory == 'Semua' || note.category == _selectedCategory;
      final matchesQuery =
          query.isEmpty ||
          note.title.toLowerCase().contains(query) ||
          note.content.toLowerCase().contains(query);

      return matchesCategory && matchesQuery;
    }).toList();
  }

  void _showFilterMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Gunakan chip kategori untuk memfilter catatan.'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final notes = _filteredNotes;

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 4,
        tooltip: 'Tambah catatan',
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AddNoteScreen()),
        ),
        icon: const Icon(Icons.add_rounded),
        label: const Text(
          'Tempel',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      bottomNavigationBar: _BottomBar(
        index: _navIndex,
        onTap: (index) => setState(() => _navIndex = index),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              sliver: SliverToBoxAdapter(child: _buildHeader(notes.length)),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              sliver: SliverToBoxAdapter(child: _buildSearch()),
            ),
            SliverToBoxAdapter(child: _buildCategories()),
            if (notes.isEmpty)
              const SliverFillRemaining(
                hasScrollBody: false,
                child: _EmptyBoard(),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 96),
                sliver: SliverGrid.builder(
                  itemCount: notes.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 18,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.82,
                  ),
                  itemBuilder: (_, index) => NoteCard(
                    note: notes[index],
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => NoteDetailScreen(note: notes[index]),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(int count) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Halo, Arif 👋',
                style: TextStyle(fontSize: 14, color: AppColors.textGrey),
              ),
              const SizedBox(height: 2),
              const Text(
                'Papan Catatanku',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.noteYellow,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '$count catatan tertempel',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(2),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [AppColors.notePink, AppColors.noteBlue],
            ),
          ),
          child: const CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, color: AppColors.textDark),
          ),
        ),
      ],
    );
  }

  Widget _buildSearch() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            onChanged: (value) => setState(() => _query = value),
            decoration: const InputDecoration(
              hintText: 'Cari catatan...',
              prefixIcon: Icon(
                Icons.search,
                color: AppColors.textGrey,
                size: 20,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 50,
          height: 50,
          child: IconButton(
            onPressed: _showFilterMessage,
            tooltip: 'Filter kategori',
            style: IconButton.styleFrom(
              backgroundColor: AppColors.textDark,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            icon: const Icon(Icons.tune, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildCategories() {
    return SizedBox(
      height: 64,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (_, index) {
          final category = _categories[index];
          final active = category == _selectedCategory;
          final dotColor = _categoryColors[category]!;

          return GestureDetector(
            onTap: () => setState(() => _selectedCategory = category),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 14),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: active ? AppColors.textDark : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: active ? AppColors.textDark : AppColors.border,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (category != 'Semua') ...[
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: dotColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                  ],
                  Text(
                    category,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: active ? Colors.white : AppColors.textDark,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _EmptyBoard extends StatelessWidget {
  const _EmptyBoard();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Transform.rotate(
          angle: -0.06,
          child: Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              color: AppColors.noteYellow,
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(25),
                  blurRadius: 10,
                  offset: const Offset(2, 6),
                ),
              ],
            ),
            child: const Icon(
              Icons.search_off_rounded,
              size: 36,
              color: AppColors.textDark,
            ),
          ),
        ),
        const SizedBox(height: 18),
        const Text(
          'Catatan tidak ditemukan',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Coba kata kunci atau kategori lain.',
          style: TextStyle(fontSize: 12, color: AppColors.textGrey),
        ),
        const SizedBox(height: 80),
      ],
    );
  }
}

class _BottomBar extends StatelessWidget {
  final int index;
  final ValueChanged<int> onTap;

  const _BottomBar({required this.index, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: index,
      onDestinationSelected: onTap,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      indicatorColor: AppColors.noteYellow,
      height: 66,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.dashboard_outlined),
          selectedIcon: Icon(Icons.dashboard_rounded),
          label: 'Papan',
        ),
        NavigationDestination(
          icon: Icon(Icons.folder_outlined),
          selectedIcon: Icon(Icons.folder_rounded),
          label: 'Arsip',
        ),
        NavigationDestination(
          icon: Icon(Icons.person_outline),
          selectedIcon: Icon(Icons.person_rounded),
          label: 'Profil',
        ),
      ],
    );
  }
}
