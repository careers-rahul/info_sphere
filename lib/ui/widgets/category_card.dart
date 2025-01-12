import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String categoryName;
  final String imagePath;
  final VoidCallback? onTap;

  const CategoryCard({
    super.key,
    required this.categoryName,
    required this.imagePath,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 180,
        child: Card(
          margin: const EdgeInsets.all(16),
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Image Background
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
              // Black Overlay with Opacity
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              // Centered Text
              Center(
                child: Text(
                  categoryName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
