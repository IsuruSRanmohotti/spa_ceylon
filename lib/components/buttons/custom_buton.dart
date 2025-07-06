
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Color? bgColor;
  final String text;
  final VoidCallback? onTap;
  const CustomButton({super.key, this.bgColor, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size.width,
        height: 55,
        decoration: BoxDecoration(
          color: bgColor ?? Colors.amber.shade700,
          borderRadius: BorderRadius.circular(15),
        ),

        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
