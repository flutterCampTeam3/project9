import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:medicine_reminder_app/data_layer/data_layer.dart';
import 'package:medicine_reminder_app/service/supabase_services.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final serviceLocator = DataInjection().locator.get<DBServices>();

  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {});
    on<SignUpEvent>(signUpNewUser);
    on<LoginEvent>(login);
    on<CheckSessionAvailability>(getSession);
    on<LogoutEvent>(logout);
    on<ResendOtpEvent>(resendOtp);
    on<SendOtpEvent>(sendOtp);
    on<ConfirmOtpEvent>(confirmOtp);
    on<ChangePasswordEvent>(updatePassword);
  }

  FutureOr<void> signUpNewUser(
      SignUpEvent event, Emitter<AuthState> emit) async {
    if (event.email.trim().isNotEmpty &&
        event.password.trim().isNotEmpty &&
        event.name.trim().isNotEmpty) {
      try {
        await serviceLocator.signUp(
            email: event.email, password: event.password);

        await serviceLocator.createUser(name: event.name, email: event.email);
        final userId = await serviceLocator.getCurrentUserId();
        await serviceLocator.getUser(id: userId);

        emit(AuthSuccessState(msg: "تم إكمال عملية التسجيل بنجاح"));
      } on AuthException catch (e) {
        emit(AuthErrorState(
            msg:
                "فشل في عملية التسجيل: ${e.statusCode}. يرجى التحقق من بريدك الإلكتروني وكلمة المرور"));
      } on Exception catch (e) {
        emit(AuthErrorState(msg: "حدث خطأ أثناء عملية التسجيل: $e"));
      }
    } else {
      emit(AuthErrorState(msg: "يرجى ملء جميع الحقول المطلوبة"));
    }
  }

  FutureOr<void> login(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    if (event.email.trim().isNotEmpty && event.password.trim().isNotEmpty) {
      try {
        await serviceLocator.login(
            email: event.email, password: event.password);
        Future.delayed(const Duration(seconds: 5));
        emit(AuthSuccessState(msg: "تم تسجيل الدخول بنجاح"));
      } on AuthException catch (e) {
        emit(AuthErrorState(
            msg:
                "البريد الإلكتروني أو كلمة المرور غير صحيحة: ${e.statusCode}. يرجى التحقق من بيانات الاعتماد الخاصة بك والمحاولة مرة أخرى"));
      } on Exception catch (e) {
        emit(AuthErrorState(msg: "حدث خطأ أثناء عملية تسجيل الدخول: $e"));
      }
    } else {
      emit(AuthErrorState(
          msg: "يرجى ملء كل من حقل البريد الإلكتروني وكلمة المرور."));
    }
  }

  FutureOr<void> getSession(
      CheckSessionAvailability event, Emitter<AuthState> emit) async {
    await Future.delayed(const Duration(seconds: 2));
    try {
      final sessionData = await serviceLocator.getCurrentSession();
      emit(SessionAvailabilityState(isAvailable: sessionData));
      final userId = await serviceLocator.getCurrentUserId();
      await serviceLocator.getUser(id: userId);
      emit(SessionAvailabilityState(isAvailable: sessionData));
    } catch (e) {}
  }

  FutureOr<void> logout(LogoutEvent event, Emitter<AuthState> emit) async {
    try {
      await serviceLocator.logout();
      emit(AuthSuccessState(msg: "تم تسجيل الخروج بنجاح"));
    } catch (e) {
      emit(AuthErrorState(msg: "حدث خطأ أثناء عملية تسجيل الخروج"));
    }
  }

  FutureOr<void> sendOtp(SendOtpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    if (event.email.trim().isNotEmpty) {
      try {
        await serviceLocator.sendOtp(email: event.email);
        serviceLocator.email = event.email;
        emit(AuthSuccessState(
            msg:
                "تم إرسال رمز OTP لإعادة تعيين كلمة المرور إلى بريدك الإلكتروني. يرجى التحقق من صندوق الوارد الخاص بك"));
      } on AuthException catch (e) {
        emit(AuthErrorState(
            msg:
                "عنوان البريد الإلكتروني غير صالح. يرجى تقديم عنوان بريد إلكتروني صالح"));
      } on Exception catch (e) {
        emit(AuthErrorState(
            msg:
                "واجهنا مشكلة أثناء معالجة طلبك. يرجى المحاولة مرة أخرى في وقت لاحق"));
      }
    } else {
      emit(AuthErrorState(msg: "يرجى تقديم عنوان بريدك الإلكتروني"));
    }
  }

  FutureOr<void> confirmOtp(
      ConfirmOtpEvent event, Emitter<AuthState> emit) async {
    if (event.otpToken.trim().isNotEmpty) {
      try {
        await serviceLocator.verifyOtp(
            email: event.email, otpToken: event.otpToken);
        emit(AuthSuccessState(
            msg: "تم تأكيد رمز OTP، يرجى إدخال كلمة المرور الجديدة"));
      } on AuthException catch (e) {
        emit(AuthErrorState(msg: "رمز OTP غير صالح، يرجى المحاولة مرة أخرى"));
      } on Exception catch (e) {
        emit(AuthErrorState(
            msg: "هناك مشكلة في خوادمنا، يرجى المحاولة مرة أخرى في وقت لاحق"));
      }
    } else {
      emit(AuthErrorState(msg: "يرجى إدخال رمز OTP"));
    }
  }

  FutureOr<void> updatePassword(
      ChangePasswordEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    if (event.password == event.confirmPassword) {
      if (event.password.trim().isNotEmpty && event.password.length >= 6) {
        try {
          await serviceLocator.changePassword(password: event.password);
          emit(AuthSuccessState(msg: "تم تغيير كلمة المرور بنجاح"));
          await serviceLocator.logout();
        } on AuthException catch (e) {
          emit(AuthErrorState(msg: "غير مسموح لك بتغيير كلمة المرور"));
        } on Exception catch (e) {
          emit(AuthErrorState(
              msg:
                  "هناك مشكلة في خوادمنا، يرجى المحاولة مرة أخرى في وقت لاحق"));
        }
      } else {
        emit(AuthErrorState(
            msg: "الرجاء إدخال كلمة مرور صالحة (6 أحرف على الأقل)"));
      }
    } else {
      emit(AuthErrorState(
          msg: "كلمات المرور غير متطابقة. يرجى التأكد من تطابق كلمات المرور"));
    }
  }

  FutureOr<void> resendOtp(
      ResendOtpEvent event, Emitter<AuthState> emit) async {
    try {
      await serviceLocator.resend();
      emit(AuthSuccessState(
          msg: "تم إعادة إرسال رمز OTP إلى ${serviceLocator.email}"));
    } catch (e) {
      emit(AuthErrorState(msg: "تعذر إرسال رمز OTP..."));
    }
  }
}
