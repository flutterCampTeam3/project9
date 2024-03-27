import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_reminder_app/extensions/screen_handler.dart';
import 'package:medicine_reminder_app/utils/colors.dart';
import 'package:medicine_reminder_app/utils/spacing.dart';
import 'package:medicine_reminder_app/views/auth/bloc/auth_bloc.dart';
import 'package:medicine_reminder_app/views/auth/view/login_page.dart';
import 'package:medicine_reminder_app/views/auth/view/otp_view.dart';
import 'package:medicine_reminder_app/widgets/custom_elevated_button.dart';
import 'package:medicine_reminder_app/widgets/custom_lodaing_circle.dart';
import 'package:medicine_reminder_app/widgets/custom_text_field.dart';
import 'package:medicine_reminder_app/widgets/custom_textfield.dart';

class ResetPasswordView extends StatelessWidget {
  ResetPasswordView({super.key});

  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: green,
        leading: IconButton(
            onPressed: () {
              context.push(view: const LoginView(), isPush: false);
            },
            icon: Icon(Icons.arrow_back, color: pureWhite)),
        title: Text(
          "الرجوع",
          style: TextStyle(
              color: pureWhite, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Align(
            alignment: Alignment.centerRight,
            child: Center(
              child: BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthSuccessState) {
                    context.getMessagesBar(msg: state.msg, color: green);
                    context.push(view: OTPView(), isPush: false);
                  } else if (state is AuthErrorState) {
                    context.getMessagesBar(msg: state.msg, color: red);
                  }
                },
                builder: (context, state) {
                  if (state is AuthLoadingState) {
                    return const LoadingScreen();
                  }
                  return Column(
                    children: [
                      height40,
                      Image.asset(
                        'assets/images/My password-bro.png',
                        width: 250,
                        height: 250,
                      ),
                      height32,
                      const Text(
                        "إعادة تعيين كلمة المرور",
                        style: TextStyle(
                            color: black,
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ),
                      const Text(
                        "أهلاً بك! فقط أدخل بريدك الإلكتروني، وسنُرسل لك رمز التحقق، لإعادة تعيين كلمة المرور، دعنا نكون جزءًا من الحل لتأمين وصولك وراحتك",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: black,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                      height20,
                      TextFieldWidget(
                        text: "البريد الالكتروني",
                        controller: emailController,
                      ),
                      const Spacer(),
                      CustomElevatedButton(
                        buttonColor: green,
                        styleColor: white,
                        text: "تابع",
                        onPressed: () {
                          context
                              .read<AuthBloc>()
                              .add(SendOtpEvent(email: emailController.text));
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
