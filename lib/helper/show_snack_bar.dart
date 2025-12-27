
import 'package:flutter/material.dart';

void showSnacbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(
          color: Colors.white,      
          fontSize: 16,             
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.blueAccent, 
      behavior: SnackBarBehavior.floating, 
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), 
      ),
      margin: const EdgeInsets.all(16), 
      duration: const Duration(seconds: 2), 
      action: SnackBarAction(
        label: 'إغلاق',
        textColor: Colors.black,
        onPressed: () {
          
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    ),
  );
}
