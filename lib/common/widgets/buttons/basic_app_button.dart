import 'package:copyify/core/configs/theme/app_colors.dart';
import 'package:flutter/material.dart';

class BasicAppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final double height;
  const BasicAppButton({
    required this.onPressed,
    required this.title,
    this.height = 80,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(height)
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white
          ),
        )
    );
  }
}
