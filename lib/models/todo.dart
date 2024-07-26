import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Todo {
  String title;
  String description;
  bool isDone;
  DateTime date;

  Todo({
    required this.title,
    required this.description,
    this.isDone = false,
    required this.date,
  });

  String get formattedDate {
    return DateFormat.yMMMd().format(date);
  }
}
