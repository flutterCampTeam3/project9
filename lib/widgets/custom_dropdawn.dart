import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:medicine_reminder_app/service/supabase_services.dart';
import 'package:medicine_reminder_app/utils/colors.dart';
import 'package:medicine_reminder_app/utils/spacing.dart';

class dropdownWidget extends StatefulWidget {
  dropdownWidget({
    super.key,
    required this.path,
    required this.title,
    this.count = 30,
    required this.type,
    required this.page,
  });
  String title;
  String path;
  int count;
  String type;
  final int page;
  @override
  State<dropdownWidget> createState() => _dropdownWidgetState();
}

class _dropdownWidgetState extends State<dropdownWidget> {
  String dropDownValue = "....";
  @override
  Widget build(BuildContext context) {
    final locator = GetIt.I.get<DBServices>();
    if (widget.page == 2) {
      if (widget.type == "day") {
        dropDownValue = locator.pellPireod.toString();
      }
      if (widget.type == "pill") {
        dropDownValue = locator.pellCount.toString();
      }
    }
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.07,
        decoration: BoxDecoration(
          color: greyColor,
          borderRadius: const BorderRadius.all(Radius.circular(14)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(widget.path),
            DropdownButton<int>(
              underline: const Text(""),
              icon: Row(
                children: [
                  const Icon(
                    Icons.arrow_drop_down,
                    color: Color(0xff9B9B9B),
                  ),
                  Text(widget.title),
                  width4,
                  Text(dropDownValue),
                ],
              ),
              onChanged: (value) {
                setState(() {
                  if (value != null) {
                    if (widget.type == "day") {
                      locator.pellPireod = value;
                    } else if (widget.type == "pill") {
                      locator.pellCount = value;
                    } else if (widget.type == "counts") {
                      locator.dosesCounts = value;
                    }
                  }
                  dropDownValue = value.toString();
                });
              },
              items: List.generate(widget.count, (index) => index + 1)
                  .map((value) => DropdownMenuItem<int>(
                        value: value,
                        child: Text(value.toString()),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
