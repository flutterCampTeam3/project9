import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:medicine_reminder_app/extensions/screen_handler.dart';
import 'package:medicine_reminder_app/model/medicine_model.dart';
import 'package:medicine_reminder_app/service/supabase_services.dart';
import 'package:medicine_reminder_app/utils/colors.dart';
import 'package:medicine_reminder_app/utils/spacing.dart';
import 'package:medicine_reminder_app/views/bottom_nav_bar/view/bottom_nav_bar.dart';
import 'package:medicine_reminder_app/views/medicine/bloc/medicine_bloc.dart';
import 'package:medicine_reminder_app/widgets/appBar_arrow_back.dart';
import 'package:medicine_reminder_app/widgets/custom_dropdawn.dart';
import 'package:medicine_reminder_app/widgets/custom_elevated_button.dart';
import 'package:medicine_reminder_app/widgets/custom_label.dart';
import 'package:medicine_reminder_app/widgets/custom_notification.dart';
import 'package:medicine_reminder_app/widgets/custom_drop_menu.dart';

class MedInformation extends StatefulWidget {
  const MedInformation({super.key});

  @override
  State<MedInformation> createState() => _MedInformationState();
}

class _MedInformationState extends State<MedInformation> {
  @override
  Widget build(BuildContext context) {
    TextEditingController pellName = TextEditingController();
    return BlocProvider(
      create: (context) => MedicineBloc(),
      child: BlocConsumer<MedicineBloc, MedicineState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
                leading: const AppBarArrowBack(),
                automaticallyImplyLeading: false),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  height40,
                  const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "معولمات الدواء",
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold),
                      )),
                  height40,
                  Image.asset(
                    'assets/images/medimage.png',
                    height: 150,
                  ),
                  height40,
                  const CustomLabel(label: 'إسم الدواء'),
                  height10,
                  SizedBox(
                    height: 48,
                    child: TextField(
                      readOnly: true,
                      controller: pellName,
                      // textDirection: TextDirection.rtl,
                      decoration: InputDecoration(
                        hintText: 'اسم الدواء',
                        icon: SvgPicture.asset("assets/icons/drugs.svg"),
                        hintTextDirection: TextDirection.rtl,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        filled: true,
                        fillColor: greyColor,
                        alignLabelWithHint: true,
                      ),
                    ),
                  ),
                  height40,
                  SizedBox(
                      height: 5 * 48.0, // 5 times the height of a single line
                      child: TextField(
                          readOnly: true,
                          controller: pellName,
                          maxLines: 5, // Display 5 lines
                          decoration: InputDecoration(
                            hintText: 'وصف الدواء',
                            hintTextDirection: TextDirection.rtl,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            filled: true,
                            fillColor: greyColor,
                            alignLabelWithHint: true,
                          ))),
                  height40,
                  const Spacer(),
                  SafeArea(
                    child: CustomElevatedButton(
                      text: "إنهاء",
                      buttonColor: green,
                      styleColor: white,
                      onPressed: () async {},
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
