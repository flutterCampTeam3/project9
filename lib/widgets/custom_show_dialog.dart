import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:medicine_reminder_app/extensions/screen_handler.dart';
import 'package:medicine_reminder_app/model/medicine_model.dart';
import 'package:medicine_reminder_app/service/supabase_services.dart';
import 'package:medicine_reminder_app/utils/spacing.dart';
import 'package:medicine_reminder_app/views/bottom_nav_bar/view/bottom_nav_bar.dart';
import 'package:medicine_reminder_app/views/medicine/bloc/medicine_bloc.dart';

class MedicineDialog extends StatelessWidget {
  const MedicineDialog({super.key, required this.medicine});
  final MedicineModel medicine;
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Align(
          alignment: Alignment.centerRight, child: Text('حالة تناول الدواء')),
      children: [
        buildDialogOption('تم أخذ الدواء', Colors.green, context, 0, medicine),
        buildDialogOption('تم التخطي', Colors.red, context, 1, medicine),
        buildDialogOption('اعادة جدولة', Colors.yellow, context, 2, medicine),
      ],
    );
  }

  SimpleDialogOption buildDialogOption(String text, Color color,
      BuildContext context, int state, MedicineModel medicine) {
    final bloc = context.read<MedicineBloc>();
    final locator = GetIt.I.get<DBServices>();

    return SimpleDialogOption(
      onPressed: () async {
        switch (state) {
          case 0:
            {
              bloc.add(UpdateStateEvent(
                  state: stateEnum.take.toString(), medicine: medicine));
            }

          case 1:
            {
              bloc.add(UpdateStateEvent(
                  state: stateEnum.skip.toString(), medicine: medicine));
            }
          case 2:
            {
              bloc.add(UpdateStateEvent(
                  state: stateEnum.reschedule.toString(), medicine: medicine));
            }
        }
        context.push(view: const BottomNav(), isPush: false);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
          ),
          width16,
          Text(
            text,
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }
}
