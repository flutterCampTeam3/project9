import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medicine_reminder_app/data_layer/data_layer.dart';
import 'package:medicine_reminder_app/service/database_configuration.dart';
import 'package:medicine_reminder_app/views/ai_chat/bloc/chat_gpt_bloc.dart';
import 'package:medicine_reminder_app/views/auth/bloc/auth_bloc.dart';
import 'package:medicine_reminder_app/views/auth/view/login_page.dart';
import 'package:medicine_reminder_app/views/auth/view/siginup_page.dart';
import 'package:medicine_reminder_app/views/bottom_nav_bar/bloc/nav_bar_bloc.dart';
import 'package:medicine_reminder_app/views/bottom_nav_bar/view/bottom_nav_bar.dart';
import 'package:medicine_reminder_app/views/med_scan_info.dart';
import 'package:medicine_reminder_app/views/medicine/bloc/medicine_bloc.dart';
import 'package:medicine_reminder_app/views/medicine/view/add_medication_page.dart';
import 'package:medicine_reminder_app/views/qr_barcode/bloc/scan_bloc.dart';
import 'package:medicine_reminder_app/views/qr_barcode/view/scan_code_page.dart';
import 'package:medicine_reminder_app/views/start_page/first_page.dart';
import 'package:medicine_reminder_app/views/start_page/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await databaseConfiguration();
  DataInjection().setup();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc()..add(CheckSessionAvailability()),
        ),
        BlocProvider(
          create: (context) => NavBarBloc(),
        ),
        BlocProvider(
          create: (context) => ScanBloc(),
        ),
        BlocProvider(
          create: (context) => ChatGptBloc(),
        ),
        BlocProvider(create: (context) => MedicineBloc()),
      ],
      child: MaterialApp(
        builder: (context, child) {
          return Directionality(
              textDirection: TextDirection.rtl, child: child!);
        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: GoogleFonts.vazirmatn().fontFamily,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
