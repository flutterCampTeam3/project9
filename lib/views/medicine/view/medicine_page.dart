import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_reminder_app/extensions/screen_handler.dart';
import 'package:medicine_reminder_app/utils/colors.dart';
import 'package:medicine_reminder_app/utils/spacing.dart';
import 'package:medicine_reminder_app/views/medicine/bloc/medicine_bloc.dart';
import 'package:medicine_reminder_app/widgets/custom_container_medican.dart';
import 'package:medicine_reminder_app/widgets/custom_shimmer_effact.dart';

class MedicineView extends StatelessWidget {
  const MedicineView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MedicineBloc()..add(MedicineLoadEvent()),
      child: Builder(builder: (context) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  height20,
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "أدويتي",
                          style: TextStyle(
                              fontSize: 40,
                              color: black,
                              fontWeight: FontWeight.w600),
                        ),
                        // TextButton(
                        //     onPressed: () {},
                        //     child: Text(
                        //       "Edit",
                        //       style: TextStyle(fontSize: 20, color: grey),
                        //     ))
                      ],
                    ),
                  ),
                  height10,
                  BlocConsumer<MedicineBloc, MedicineState>(
                      listener: (context, state) {
                    if (state is MedicineErrorState) {
                      context.getMessages(msg: state.msg, color: red);
                    }
                  }, builder: (context, state) {
                    if (state is MedicineLoadingState) {
                      return shimmerEffect();
                    }
                    if (state is MedicineLoadedState) {
                      if (state.list.isNotEmpty) {
                        return Expanded(
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.list.length,
                              itemBuilder: (context, index) {
                                return ContainerMedication(
                                  medicine: state.list[index],
                                  isShowState: false,
                                  isEditState: true,
                                );
                              }),
                        );
                      }
                    }
                    return SizedBox(
                      height: context.getHeight() * 0.5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/Medicine-amico.png"),
                          const Text(
                            "قم بإضافة دواء",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
