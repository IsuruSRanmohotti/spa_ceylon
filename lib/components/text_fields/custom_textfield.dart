import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final IconData? prefixIcon;
  final String label;
  final bool isPassword;
  final Color? bgColor;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final int maxLines;
  
  const CustomTextField({
    super.key,
    this.prefixIcon,
    required this.label,
    this.isPassword = false,
    this.controller,
    this.bgColor,
    this.textInputType,this.maxLines =1
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        style: TextStyle(color: Colors.grey.shade300),
        maxLines: maxLines,
        cursorColor: Colors.grey,
        keyboardType: textInputType,
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
          fillColor: bgColor ?? Colors.black.withAlpha(50),
          filled: true,

          label: Text(label),
        ),
      ),
    );
  }
}
