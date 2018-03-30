import 'package:flutter/material.dart';

class Reminder {
  bool isExpanded;
  Color avatarColor;
  String name;
  String description;
  DateTime creationDate;

  Reminder(this.isExpanded, this.avatarColor, this.name, this.description, this.creationDate);
}