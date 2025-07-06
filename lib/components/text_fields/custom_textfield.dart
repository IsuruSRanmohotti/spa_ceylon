import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final IconData? prefixIcon;
  final String label;
  final bool isPassword;
  final TextEditingController? controller;
  const CustomTextField({
    super.key,
    this.prefixIcon,
    required this.label,
    this.isPassword = false,
    this.controller
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        style: TextStyle(color: Colors.grey.shade300),
        cursorColor: Colors.grey,
        decoration: InputDecoration(
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.grey.shade800),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.grey.shade800),
          ),
          fillColor: Colors.black.withAlpha(50),
          filled: true,

          label: Text(label),
        ),
      ),
    );
  }
}
