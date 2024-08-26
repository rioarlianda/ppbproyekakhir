import 'package:flutter/material.dart';

class CustomForm extends StatelessWidget {
  const CustomForm({
    super.key,
    required this.controller,
    required this.icon,
    required this.label,
    this.isObscure = false,
  });

  final TextEditingController controller;
  final Icon icon;
  final String label;
  final bool isObscure;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: TextField(
        controller: controller,
        obscureText: isObscure,
        decoration: InputDecoration(
          label: Text(label),
          prefixIcon: icon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
