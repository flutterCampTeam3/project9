import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medicine_reminder_app/extensions/screen_handler.dart';
import 'package:medicine_reminder_app/utils/colors.dart';
import 'package:medicine_reminder_app/utils/spacing.dart';
import 'package:medicine_reminder_app/views/auth/bloc/auth_bloc.dart';
import 'package:medicine_reminder_app/views/auth/view/siginup_page.dart';
import 'package:medicine_reminder_app/views/auth/view/reset_password_page.dart';
import 'package:medicine_reminder_app/views/bottom_nav_bar/view/bottom_nav_bar.dart';
import 'package:medicine_reminder_app/widgets/custom_elevated_button.dart';
import 'package:medicine_reminder_app/widgets/custom_lodaing_circle.dart';
import 'package:medicine_reminder_app/widgets/custom_textfield.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    emailController.text = "ss@gmail.com";
    passwordController.text = "11223344";
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthSuccessState) {
                context.push(view: const BottomNav(), isPush: true);
                context.showSuccessSnackBar(context, state.msg);
              } else if (state is AuthErrorState) {
                context.showErrorSnackBar(
                  context,
                  state.msg,
                );
              }
            },
            builder: (context, state) {
              if (state is AuthLoadingState) {
                return const LoadingScreen();
              }
              return Column(
                children: [
                  Container(
                    width: context.getWidth(),
                    height: context.getHeight() / 2.2,
                    padding: const EdgeInsets.all(16),
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
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          height40,
                          Image.asset(
                            'assets/images/newIcon.png',
                            width: 200,
                            height: 200,
                          ),
                          height40,
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "  تسجيل دخول",
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
                  ),
                  height16,
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        TextFieldWidget(
                          text: "الايميل",
                          controller: emailController,
                        ),
                        height10,
                        TextFieldWidget(
                          text: "كلمة المرور",
                          controller: passwordController,
                          obscure: true,
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                            onPressed: () {
                              context.push(
                                  view: ResetPasswordView(), isPush: false);
                            },
                            child: Text(
                              "هل نسيت كلمة المرور؟",
                              style: TextStyle(
                                fontFamily: 'MarkaziText',
                                color: greenText,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        // const Spacer(),
                        CustomElevatedButton(
                            buttonColor: darkGreen,
                            onPressed: () {
                              context.read<AuthBloc>().add(LoginEvent(
                                  email: emailController.text,
                                  password: passwordController.text));
                            },
                            text: "تسجيل الدخول",
                            styleColor: white),
                        height10,
                        RichText(
                          text: TextSpan(
                            text: 'لا يوجد لديك حساب؟ ',
                            style: const TextStyle(
                              color: black,
                              fontSize: 16,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'سجل الآن',
                                style: TextStyle(
                                  color: greenText,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    context.push(
                                        view: const SignUpView(),
                                        isPush: false);
                                  },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
