import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_reminder_app/utils/colors.dart';
import 'package:medicine_reminder_app/utils/spacing.dart';
import 'package:medicine_reminder_app/views/qr_barcode/bloc/scan_bloc.dart';
import 'package:medicine_reminder_app/widgets/custom_elevated_button.dart';


class ScanView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: green,
        leading: Icon(Icons.qr_code_scanner, color: white,),
        title: Text('مسح الباركود', style: TextStyle(color: white, fontFamily: 'MarkaziText',
          ),),
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
                         Image.asset(
                          'assets/images/logo_2.png',
                          width: 175,
                          height: 175,
                        ),
                        Text(
                          "لنقم بالمسح",
                          style: TextStyle(color: green, fontSize: 30, fontFamily: 'MarkaziText',
                          ),
                        ),
                      ],
                    );
                  } else if (state is ScanSuccess) {
                    return Text(
                      state.qrString,
                      style: TextStyle(color: green, fontSize: 30, fontFamily: 'MarkaziText',
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
                        Text(
                          'عذرًا، لم نتمكن من قراءة الباركود. يرجى المحاولة مرة أخرى.',
                          style: TextStyle(color: Colors.red, fontSize: 30, fontFamily: 'MarkaziText',
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
                          style: TextStyle(color: green, fontSize: 30, fontFamily: 'MarkaziText',
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              height100,
              CustomElevatedButton(
                onPressed: (){
                  BlocProvider.of<ScanBloc>(context).add(ScanQR());
                },
                text: "امسح الباركود",
                buttonColor: green,
                styleColor: pureWhite,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
