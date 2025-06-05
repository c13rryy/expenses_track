import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.label,
    required this.controller,
    this.prefixText,
    this.textFieldLenght,
    this.type = TextInputType.text,
  });


  final String label;
  final TextEditingController controller;
  final String? prefixText;
  final TextInputType type;
  final int? textFieldLenght;

  @override
  Widget build(BuildContext context) {
    return  TextField(
      controller: controller,
      maxLength: textFieldLenght,
      decoration: InputDecoration(
        prefixText: prefixText,
        label: Text(label),
      ),
      keyboardType: type,
    );
  }
}
