import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medicine_reminder_app/extensions/screen_handler.dart';
import 'package:medicine_reminder_app/utils/colors.dart';
import 'package:medicine_reminder_app/utils/spacing.dart';
import 'package:medicine_reminder_app/views/auth/bloc/auth_bloc.dart';
import 'package:medicine_reminder_app/views/auth/view/login_page.dart';
import 'package:medicine_reminder_app/widgets/custom_elevated_button.dart';
import 'package:medicine_reminder_app/widgets/custom_text_field.dart';
import 'package:medicine_reminder_app/widgets/custom_textfield.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: Builder(builder: (context) {
        TextEditingController nameController = TextEditingController();
        TextEditingController emailController = TextEditingController();
        TextEditingController passwordController = TextEditingController();
        return Scaffold(
          body: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthSuccessState) {
                context.getMessagesBar(msg: state.msg, color: green);
                context.push(view: const LoginView(), isPush: false);
              } else if (state is AuthErrorState) {
                context.getMessagesBar(msg: state.msg, color: red);
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  Container(
                    width: context.getWidth(),
                    height: 320,
                    // padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [greenText, darkGreen],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        height40,
                        Image.asset(
                          'assets/images/newIcon.png',
                          width: 180,
                          height: 180,
                        ),
                        height10,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "  تسجيل حساب",
                                style: TextStyle(
                                    color: whiteColor,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  height16,
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // const Text(
                          //   "اسم المستخدم",
                          //   style: TextStyle(
                          //     fontFamily: 'MarkaziText',
                          //     color: black,
                          //     fontWeight: FontWeight.bold,
                          //     fontSize: 20,
                          //   ),
                          // ),

                          TextFieldWidget(
                            text: "اسم المستخدم",
                            controller: nameController,
                          ),
                          height26,
                          TextFieldWidget(
                            text: "الايميل",
                            controller: emailController,
                          ),
                          height26,
                          TextFieldWidget(
                            text: "كلمة المرور",
                            controller: passwordController,
                          ),
                          const Spacer(),

                          CustomElevatedButton(
                              onPressed: () {
                                context.read<AuthBloc>().add(SignUpEvent(
                                    email: emailController.text,
                                    name: nameController.text,
                                    password: passwordController.text));
                              },
                              buttonColor: darkGreen,
                              text: "تسجيل جديد",
                              styleColor: white),
                          TextButton(
                            onPressed: () {
                              context.push(
                                  view: const LoginView(), isPush: false);
                            },
                            child: Text(
                              "هل لديك حساب مسبقًا؟",
                              style: TextStyle(
                                color: greenText,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      }),
    );
  }
}
