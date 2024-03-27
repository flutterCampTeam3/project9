import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.buttonColor,
    required this.text,
    required this.styleColor,
    this.onPressed,
    this.borderColor = Colors.transparent,
  });

  final Color buttonColor;
  final Color borderColor;
  final Color styleColor;
  final String text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(const Size(double.infinity, 60)),
        backgroundColor: MaterialStateProperty.all(buttonColor),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: borderColor),
        )),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(
                color: styleColor, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
