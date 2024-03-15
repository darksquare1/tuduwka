import 'package:flutter/material.dart';

class Category {
  final String id;
  late final String name;
  final DateTime createdAt;

  Category({
    required this.id,
    required this.name,
    required this.createdAt,
  });
}
