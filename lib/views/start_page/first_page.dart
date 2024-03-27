import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medicine_reminder_app/extensions/screen_handler.dart';
import 'package:medicine_reminder_app/utils/colors.dart';
import 'package:medicine_reminder_app/utils/spacing.dart';
import 'package:medicine_reminder_app/views/auth/view/login_page.dart';
import 'package:medicine_reminder_app/views/auth/view/siginup_page.dart';
import 'package:medicine_reminder_app/views/bottom_nav_bar/view/bottom_nav_bar.dart';
import 'package:medicine_reminder_app/widgets/custom_elevated_button.dart';

class FirstView extends StatelessWidget {
  const FirstView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomSheet: Container(
        height: 250,
        width: double.infinity,
        decoration: BoxDecoration(
            color: white,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              height40,
              CustomElevatedButton(
                text: "تسجيل الدخول",
                buttonColor: darkGreen,
                styleColor: white,
                onPressed: () {
                  context.push(view: const LoginView(), isPush: false);
                },
              ),
              height20,
              // CustomElevatedButton(
              //   text: "تسجيل الدخول كزائر",
              //   buttonColor: white,
              //   borderColor: green,
              //   styleColor: black,
              //   onPressed: () {
              //     context.push(view: const BottomNav(), isPush: false);
              //   },
              // ),
              // height20,
              CustomElevatedButton(
                text: "تسجيل جديد",
                buttonColor: whiteColor,
                borderColor: greenText,
                styleColor: black,
                onPressed: () {
                  // ** here is logic ** \\
                  context.push(view: const SignUpView(), isPush: false);
                },
              ),
            ],
          ),
        ),
      ),
      body: Container(
        height: double.maxFinite,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [greenText, darkGreen],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/newIcon.png',
                width: 200,
              ),
              height100
            ],
          ),
        ),
      ),
    );
  }
}
