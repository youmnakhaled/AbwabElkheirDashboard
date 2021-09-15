import '../Services/UtilityFunctions.dart';
import 'package:flutter/material.dart';

class Hasad {
  final String title;
  final String link;

  const Hasad({
    @required this.title,
    @required this.link,
  });
  factory Hasad.fromJson(Map<String, dynamic> json) {
    return Hasad(
      title: json['title'],
      link: json['link'],
    );
  }
}
