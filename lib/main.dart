import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_reminder_app/data_layer/data_layer.dart';
import 'package:medicine_reminder_app/service/database_configuration.dart';
import 'package:medicine_reminder_app/views/ai_chat/bloc/chat_gpt_bloc.dart';
import 'package:medicine_reminder_app/views/auth/bloc/auth_bloc.dart';
import 'package:medicine_reminder_app/views/bottom_nav_bar/bloc/nav_bar_bloc.dart';
import 'package:medicine_reminder_app/views/medicine/bloc/medicine_bloc.dart';
import 'package:medicine_reminder_app/views/qr_barcode/bloc/scan_bloc.dart';
import 'package:medicine_reminder_app/views/start_page/splash_page.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //---------------------notifiction--------------
  //Remove this method to stop OneSignal Debugging
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize("0ff96812-1134-4d5d-91ef-a0f26df38061");
// The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  OneSignal.Notifications.requestPermission(true);
//-----------------------------------------------
  
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
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
