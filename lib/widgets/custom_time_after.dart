import 'package:flutter/material.dart';
import 'package:medicine_reminder_app/utils/colors.dart';

class TimeAferWidget extends StatelessWidget {
  const TimeAferWidget({super.key, required this.time, this.onPressed});
  final String time;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          height: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: greenText)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                time,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
