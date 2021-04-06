import '../Services/UtilityFunctions.dart';
import 'package:flutter/material.dart';

class Case {
  final int donations;
  final bool isActive;
  final List<String> images;
  final String id;
  final String title;
  final String description;
  final int totalPrice;
  final String category;

  const Case({
    @required this.description,
    @required this.category,
    @required this.donations,
    @required this.id,
    @required this.images,
    @required this.isActive,
    @required this.title,
    @required this.totalPrice,
  });
  factory Case.fromJson(Map<String, dynamic> json) {
    return Case(
      category: json['category'],
      description: json['description'],
      donations: json['donations'],
      id: json['id'],
      isActive: json['isActive'],
      title: json['title'],
      totalPrice: json['totalPrice'],
      images: UtilityFunctions.parseString(json['images']),
    );
  }
}
