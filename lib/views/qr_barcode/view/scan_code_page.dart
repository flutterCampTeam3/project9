import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_reminder_app/extensions/screen_handler.dart';
import 'package:medicine_reminder_app/model/scan_model.dart';
import 'package:medicine_reminder_app/service/supabase_services.dart';
import 'package:medicine_reminder_app/utils/colors.dart';
import 'package:medicine_reminder_app/utils/spacing.dart';
import 'package:medicine_reminder_app/views/med_scan_info.dart';
import 'package:medicine_reminder_app/views/qr_barcode/bloc/scan_bloc.dart';
import 'package:medicine_reminder_app/widgets/custom_elevated_button.dart';

class ScanView extends StatelessWidget {
  const ScanView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: green,
        leading: Icon(
          Icons.qr_code_scanner,
          color: white,
        ),
        title: Text(
          'مسح الباركود',
          style: TextStyle(
              color: white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BlocBuilder<ScanBloc, ScanState>(
                builder: (context, state) {
                  if (state is ScanInitial) {
                    return Column(
                      children: [
                        height60,
                        Image.asset(
                          'assets/images/logo_2.png',
                          width: 175,
                          height: 175,
                        ),
                        Text(
                          "لنقم بالمسح",
                          style: TextStyle(
                            color: green,
                            fontSize: 30,
                          ),
                        ),
                      ],
                    );
                  } else if (state is ScanSuccess) {
                    return Text(
                      state.qrString,
                      style: TextStyle(
                        color: green,
                        fontSize: 30,
                        fontFamily: 'MarkaziText',
                      ),
                    );
                  } else if (state is ScanFailure) {
                    return Column(
                      children: [
                        Image.asset(
                          'assets/images/logo_2.png',
                          width: 175,
                          height: 175,
                        ),
                        const Text(
                          'عذرًا، لم نتمكن من قراءة الباركود. يرجى المحاولة مرة أخرى.',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 30,
                            fontFamily: 'MarkaziText',
                          ),
                        ),
                      ],
                    );
                  } else if (state is ScanCanceled) {
                    return Column(
                      children: [
                        Image.asset(
                          'assets/images/logo_2.png',
                          width: 175,
                          height: 175,
                        ),
                        Text(
                          'تم إلغاء مسح الباركود',
                          style: TextStyle(
                            color: green,
                            fontSize: 30,
                            fontFamily: 'MarkaziText',
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              const Spacer(),
              CustomElevatedButton(
                onPressed: () async {
                  // BlocProvider.of<ScanBloc>(context).add(ScanQR());
                  final ScanModel result =
                      await DBServices().getScanData(code: '6281150553613');
                  context.push(
                      view: MedInformation(
                        disc: result.desc!,
                        name: result.name!,
                        image: result.image!,
                      ),
                      isPush: false);
                },
                text: "امسح الباركود",
                buttonColor: green,
                styleColor: pureWhite,
              ),
              height20
            ],
          ),
        ),
      ),
    );
  }
}
