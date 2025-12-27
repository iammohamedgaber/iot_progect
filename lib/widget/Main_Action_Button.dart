import 'package:flutter/material.dart';

class MainActionButton extends StatelessWidget {
  final String title;
  final Color color;
  final Future<void> Function()? onTap;

  const MainActionButton({
    super.key,
    required this.title,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: onTap != null ? () => onTap!() : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
