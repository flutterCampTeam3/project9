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

class AddMedicationPage extends StatelessWidget {
  const AddMedicationPage({super.key});

  @override
  Widget build(BuildContext context) {
    int seletctedType = 1;
    final locator = GetIt.I.get<DBServices>();
    TextEditingController pellName = TextEditingController();
    return BlocProvider(
      create: (context) => MedicineBloc(),
      child: BlocConsumer<MedicineBloc, MedicineState>(
        listener: (context, state) {
          if (state is MedicineSuccessState) {
            context.push(view: const BottomNav(), isPush: false);
            context.getMessages(msg: state.msg, color: green);
          } else if (state is MedicineErrorState) {
            context.getMessages(msg: state.msg, color: red);
          }
        },
        builder: (context, state) {
          final bloc = BlocProvider.of<MedicineBloc>(context);
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
                actions: const [AppBarArrowBack()],
                automaticallyImplyLeading: false),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  height40,
                  const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "إضافة دواء",
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold),
                      )),
                  height40,
                  const CustomLabel(label: 'إسم الدواء'),
                  height10,
                  SizedBox(
                    height: 48,
                    width: 319,
                    child: TextField(
                      controller: pellName,
                      // textDirection: TextDirection.rtl,
                      decoration: InputDecoration(
                        hintText: 'أكتب ...',
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(
                              right: 15, top: 12, bottom: 18),
                          child: SvgPicture.asset("assets/icons/drugs.svg"),
                        ),
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
                  height32,
                  const CustomLabel(
                    label: "كم حبة باليوم ومدة الدواء",
                  ),
                  height10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // DropMenu(),
                      SizedBox(
                        height: 48,
                        child: dropdownWidget(
                          type: '',
                          title: "يوم",
                          path: 'assets/images/calendar-fill 1.png',
                          count: 30,
                          page: 1,
                        ),
                      ),
                      width4,
                      SizedBox(
                        height: 48,
                        child: dropdownWidget(
                          type: 'counts',
                          title: "حبة",
                          path: 'assets/images/calendar-fill 1.png',
                          count: 3,
                          page: 1,
                        ),
                      ),
                    ],
                  ),
                  height32,
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: greyColor,
                      borderRadius: const BorderRadius.all(Radius.circular(14)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            // bloc.add(ChangeTypeEvent(num: 1));
                          },
                          child: Row(
                            children: [
                              Radio(
                                fillColor: MaterialStatePropertyAll(
                                    textfieldGreenColor),
                                value: 1,
                                groupValue: seletctedType,
                                onChanged: (_) {
                                  // bloc.add(ChangeTypeEvent(num: 1));
                                },
                              ),
                              const Text("قبل الاكل"),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // bloc.add(ChangeTypeEvent(num: 2));
                          },
                          child: Row(
                            children: [
                              Radio(
                                fillColor: MaterialStatePropertyAll(
                                    textfieldGreenColor),
                                value: 2,
                                groupValue: seletctedType,
                                onChanged: (_) {
                                  // bloc.add(ChangeTypeEvent(num: 2));
                                },
                              ),
                              const Text(" بعد الاكل"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  height32,
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "عدد الجرعات",
                              style: TextStyle(fontSize: 15),
                            ),
                            height10,
                            SizedBox(
                              height: 48,
                              child: dropdownWidget(
                                type: 'counts',
                                title: "جرعة",
                                path: 'assets/images/calendar-fill 1.png',
                                count: 3,
                                page: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      width8,
                      const Expanded(
                        child: Column(
                          children: [
                            CustomLabel(label: "إشعارات"),
                            height10,
                            Notifications(),
                          ],
                        ),
                      )
                    ],
                  ),
                  const Spacer(),
                  SafeArea(
                    child: CustomElevatedButton(
                      text: "إنهاء",
                      buttonColor: green,
                      styleColor: white,
                      onPressed: () async {
                        final userId = await locator.getCurrentUserId();
                        MedicineModel newMedicine = MedicineModel(
                            count: locator.pellCount,
                            name: pellName.text,
                            period: locator.pellPireod,
                            time: locator.time.toString(),
                            userId: userId);
                        bloc.add(MedicineAdded(medicine: newMedicine));
                      },
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
