import 'package:flutter/material.dart';

class NoteTextFieldWidget extends StatelessWidget {
  const NoteTextFieldWidget({
    super.key,
    required this.titleController,
    required this.hintText,
    required this.maxLines,
    required this.style,
  });

  final TextEditingController titleController;
  final String hintText;
  final int maxLines;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: titleController,
      style: style,
      autofocus: true,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.zero,
      ),
      maxLines: maxLines,
    );
  }
}
