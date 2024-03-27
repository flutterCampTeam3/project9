import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_reminder_app/extensions/screen_handler.dart';
import 'package:medicine_reminder_app/utils/colors.dart';
import 'package:medicine_reminder_app/utils/spacing.dart';
import 'package:medicine_reminder_app/views/auth/bloc/auth_bloc.dart';
import 'package:medicine_reminder_app/views/auth/view/login_page.dart';
import 'package:medicine_reminder_app/widgets/custom_elevated_button.dart';
import 'package:medicine_reminder_app/widgets/custom_text_field.dart';

class ChangePasswordView extends StatelessWidget {
  ChangePasswordView({super.key});
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccessState) {
          context.push(view: const LoginView(), isPush: true);
          context.showSuccessSnackBar(
            context,
            state.msg,
          );
        } else if (state is AuthErrorState) {
          context.showErrorSnackBar(
            context,
            state.msg,
          );
        }
      },
      builder: (context, state) {
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
                color: pureWhite,
                fontFamily: 'MarkaziText',
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    "كلمة المرور الجديدة",
                    style: TextStyle(
                      color: black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                height10,
                TextAuth(
                  controller: newPasswordController,
                  hintText: "كلمة المرور",
                ),
                height20,
                const Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    "تأكيد كلمة المرور",
                    style: TextStyle(
                      fontFamily: 'MarkaziText',
                      color: black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                height10,
                TextAuth(
                  controller: confirmPasswordController,
                  hintText: "تاكيد كلمة المرور",
                ),
                height20,
                CustomElevatedButton(
                  buttonColor: green,
                  styleColor: white,
                  text: "تابع",
                  onPressed: () {
                    context.read<AuthBloc>().add(ChangePasswordEvent(
                        password: newPasswordController.text,
                        confirmPassword: confirmPasswordController.text));
                  },
                ),
                TextButton(
                    onPressed: () {
                      context.push(view: const LoginView(), isPush: true);
                    },
                    child: Text(
                      "الرجوع الى تسجيل الدخول",
                      style: TextStyle(
                        color: grey,
                        fontFamily: 'MarkaziText',
                      ),
                    ))
              ],
            ),
          ),
        );
      },
    );
  }
}
