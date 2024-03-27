import 'package:flutter/material.dart';
import 'package:medicine_reminder_app/utils/colors.dart';

class AppBarArrowBack extends StatelessWidget {
  const AppBarArrowBack({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 15, top: 8, bottom: 8),
      child: Container(
        decoration: BoxDecoration(
            color: greyColor,
            borderRadius: const BorderRadius.all(Radius.circular(7))),
        child: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: darkGreyColor),
        ),
      ),
    );
  }
}
