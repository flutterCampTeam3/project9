import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:medicine_reminder_app/extensions/screen_handler.dart';
import 'package:medicine_reminder_app/model/medicine_model.dart';
import 'package:medicine_reminder_app/utils/colors.dart';
import 'package:medicine_reminder_app/utils/spacing.dart';
import 'package:medicine_reminder_app/views/medicine/view/edit_medicine_page.dart';
import 'package:medicine_reminder_app/widgets/custom_button.dart';
import 'package:medicine_reminder_app/widgets/custom_show_dialog.dart';
import 'package:medicine_reminder_app/widgets/custom_time_after.dart';

class ContainerMedication extends StatelessWidget {
  const ContainerMedication(
      {super.key,
      this.isShowState = false,
      this.isEditState = false,
      required this.medicine,
      this.onTap});

  final bool isShowState;
  final bool isEditState;
  final MedicineModel medicine;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return isShowState
        ? InkWell(
            onTap: onTap,
            child: Container(
              width: context.getWidth(),
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset("assets/icons/drugs.svg"),
                  width8,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        medicine.name!, // Medicine Name
                        style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 15,
                            color: black,
                            fontWeight: FontWeight.w500),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            medicine
                                .getTimeWithAmPm(medicine.time!), // Time zone
                            style: const TextStyle(
                              fontFamily: 'NotoSansArabic',
                              fontSize: 15,
                              color: Color(0xff504E4E),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.circle,
                            size: 10,
                            color: medicine.state == stateEnum.notYet
                                ? red
                                : medicine.state == stateEnum.take
                                    ? green
                                    : medicine.state == stateEnum.skip
                                        ? Colors.orange
                                        : Colors.yellow,
                          ),
                          TextButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return MedicineDialog(medicine: medicine);
                                },
                              );
                            },
                            child: Text(
                              medicine.state == stateEnum.notYet
                                  ? "لم يتم اخذ الدواء بعد"
                                  : medicine.state == stateEnum.skip
                                      ? "تم تخطي موعد اخذ الدواء"
                                      : medicine.state == stateEnum.take
                                          ? "تم اخذ الدواء في الموعد"
                                          : "تم إعادة الجدولة",
                              style: const TextStyle(
                                fontFamily: 'NotoSansArabic',
                                fontSize: 15,
                                color: Color(0xff504E4E),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        : Container(
            width: context.getWidth(),
            height: context.getHeight() / 9,
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset("assets/icons/drugs.svg"),
                width8,
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      medicine.name!,
                      style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontFamily: 'NotoSansArabic',
                          fontSize: 15,
                          color: black,
                          fontWeight: FontWeight.w500),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        width4,
                        Text(
                          medicine.getTimeWithAmPm(medicine.time!),
                          style: const TextStyle(
                            fontFamily: 'NotoSansArabic',
                            fontSize: 15,
                            color: Color(0xff504E4E),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        width4,
                        const Text(
                          "تم",
                          style: TextStyle(
                            fontFamily: 'NotoSansArabic',
                            fontSize: 15,
                            color: Color(0xff504E4E),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    InkWell(
                        onTap: () {
                          context.push(
                              view: EditMedicineView(medicine: medicine),
                              isPush: true);
                        },
                        child: Image.asset('assets/images/edit.png')),
                    width4,
                    InkWell(
                        onTap: () {
                          moreBottomSheet(context);
                        },
                        child: const Icon(Icons.keyboard_arrow_down_rounded)),
                  ],
                ),
              ],
            ),
          );
  }

  moreBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "تنبيه دواء الزنك\nبعد الاكل، 8:00",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ButtonWidget(
                    onPressed: () {
                      Navigator.pop(context);
                      reschadulBottomSheet(context);
                    },
                    text: ("اعادة جدولة"),
                    backgroundColor: greenText,
                    textColor: whiteColor,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ButtonWidget(
                    onPressed: () {},
                    text: ("تخطي"),
                    backgroundColor: greenText,
                    textColor: whiteColor,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          );
        });
  }

  reschadulBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "اعادة الجدولة\n8:00",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      Divider(
                        color: greenText,
                      ),
                      Text("إضافة وقت",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: greenText)),
                      height10,
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              DateTime time = DateTime.parse(medicine.time!);
                              var time2 = time.add(const Duration(minutes: 10));
                              final reTime = DateFormat.jm().format(time2);
                            },
                            child: const TimeAferWidget(
                              time: "10 دقائق",
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              DateTime time = DateTime.parse(medicine.time!);
                              var time2 = time.add(const Duration(minutes: 30));
                              final reTime = DateFormat.jm().format(time2);
                            },
                            child: const TimeAferWidget(
                              time: "30 دقيقة",
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              DateTime time = DateTime.parse(medicine.time!);
                              var time2 = time.add(const Duration(minutes: 60));
                              final reTime = DateFormat.jm().format(time2);
                            },
                            child: const TimeAferWidget(
                              time: "60 دقيقة",
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              DateTime time = DateTime.parse(medicine.time!);
                              var time2 =
                                  time.add(const Duration(minutes: 120));
                              final reTime = DateFormat.jm().format(time2);
                            },
                            child: const TimeAferWidget(
                              time: "120 دقيقة",
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
