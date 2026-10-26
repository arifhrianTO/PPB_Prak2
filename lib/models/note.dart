import 'package:flutter/material.dart';

class Note {
  final String title;
  final String content;
  final String category;
  final String priority;
  final String date;
  final String time;
  final Color color;
  final IconData icon;

  const Note({
    required this.title,
    required this.content,
    required this.category,
    required this.priority,
    required this.date,
    required this.time,
    required this.color,
    required this.icon,
  });
}
