import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medicine_reminder_app/extensions/screen_handler.dart';
import 'package:medicine_reminder_app/utils/colors.dart';
import 'package:medicine_reminder_app/utils/spacing.dart';
import 'package:medicine_reminder_app/views/auth/bloc/auth_bloc.dart';
import 'package:medicine_reminder_app/views/start_page/first_page.dart';

class HeaderHomePage extends StatelessWidget {
  const HeaderHomePage({super.key, required this.name});
  final String name;
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccessState) {
          context.push(view: const FirstView(), isPush: true);
          // context.showSuccessSnackBar(
          //   context,
          //   state.msg,
          // );
          context.getMessages(msg: state.msg, color: green);
        } else if (state is AuthErrorState) {
          // context.showErrorSnackBar(
          //   context,
          //   state.msg,
          // );
          context.getMessages(msg: state.msg, color: red);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
          color: green,
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              bottom: -35,
              left: 30,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: Column(
                  children: [
                    height10,
                    Image.asset(
                      "assets/images/saed.png",
                      height: 86,
                    ),
                    Text(
                      "ساعد",
                      style: TextStyle(
                        color: teal,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              right: 30,
              bottom: 0,
              child: SizedBox(
                width: 100,
                height: 120,
                child: Text(
                  "مرحبا \n$name ",
                  style: TextStyle(
                      fontFamily: 'MarkaziText',
                      fontSize: 40,
                      color: pureWhite,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 30,
              child: SizedBox(
                width: 100,
                height: 100,
                child: Text(
                  "ًُ",
                  style: TextStyle(
                      fontSize: 40,
                      color: pureWhite,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
            Positioned(
              top: 20,
              left: 7,
              child: SizedBox(
                width: 26,
                height: 26,
                child: Center(
                  child: IconButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(LogoutEvent());
                      },
                      icon: Icon(
                        Icons.logout,
                        color: white,
                      )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
