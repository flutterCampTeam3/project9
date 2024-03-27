import 'package:flutter/material.dart';
import 'package:medicine_reminder_app/utils/spacing.dart';

// ignore: must_be_immutable
class TextFieldWidget extends StatelessWidget {
  TextFieldWidget(
      {super.key, required this.text, required this.controller, this.obscure});
  final String text;
  TextEditingController? controller;
  bool? obscure;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        height10,
        TextField(
          controller: controller,
          obscureText: obscure ?? false,
          decoration: InputDecoration(
              border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          )),
        )
      ],
    );
  }
}
