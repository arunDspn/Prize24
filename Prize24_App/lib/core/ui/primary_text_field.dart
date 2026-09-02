import 'package:flutter/material.dart';

class PrimaryTextField extends StatelessWidget {
  PrimaryTextField({
    required this.hint,
    required this.controller,
    required this.validator,
    this.keyboardType,
    super.key,
  });
  final String hint;
  int? maxLines;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        style: const TextStyle(color: Colors.grey, fontFamily: 'Gilroy'),
        validator: validator,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey, fontFamily: 'Gilroy'),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
