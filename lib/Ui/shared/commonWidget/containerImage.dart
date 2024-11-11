import 'package:flutter/material.dart';

class Containerimage extends StatelessWidget {
  final double height;
  final double width;
  final String? imageUrl;

  const Containerimage({
    required this.height,
    required this.width,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    // Check if imageUrl is not null or empty
   

    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: Image.network(
      imageUrl!, // Ensure this path is correct
      height: height,
      width: width,
    ),
    );
  }
}
