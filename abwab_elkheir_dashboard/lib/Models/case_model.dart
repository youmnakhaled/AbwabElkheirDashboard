import '../Services/UtilityFunctions.dart';
import 'package:flutter/material.dart';

class Case {
  final String status;
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
    @required this.status,
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
      status: json['status'],
      id: json['_id'],
      isActive: json['isActive'],
      title: json['title'],
      totalPrice: json['totalPrice'],
      images: UtilityFunctions.parseString(json['images']),
    );
  }
}
