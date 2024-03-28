import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:medicine_reminder_app/model/medicine_model.dart';
import 'package:medicine_reminder_app/service/supabase_services.dart';
import 'package:meta/meta.dart';

part 'medicine_event.dart';
part 'medicine_state.dart';

class MedicineBloc extends Bloc<MedicineEvent, MedicineState> {
  final locator = GetIt.I.get<DBServices>();
  List<MedicineModel> listOfMedicine = [];
  int selectedType = 1;

  MedicineBloc() : super(MedicineInitial()) {
    on<MedicineEvent>((event, emit) {});
    on<MedicineLoadEvent>(loadMedicineData);
    on<ChangeRadioEvent>(changeRadio);
    on<MedicineAdded>(addMedicine);
    on<MedicineUpdated>(updateMedicine);
    on<MedicineDeleted>(deleteMedicine);
  }

  FutureOr<void> loadMedicineData(
      MedicineLoadEvent event, Emitter<MedicineState> emit) async {
    emit(MedicineLoadingState());
    try {
      listOfMedicine = await locator.getAllMedicine();
      emit(MedicineLoadedState(list: listOfMedicine));
    } catch (e) {
      emit(MedicineErrorState(
          msg: "حدث خطأ أثناء تحميل البيانات من قاعدة البيانات"));
    }
  }

  FutureOr<void> addMedicine(
      MedicineAdded event, Emitter<MedicineState> emit) async {
    if (event.name.trim().isNotEmpty &&
        locator.pellCount != 0 &&
        locator.dosesCounts != 0 &&
        locator.pellPireod != 0) {
      try {
        String condition;
        final userId = await locator.getCurrentUserId();
        emit(MedicineLoadedState(list: listOfMedicine));
        if (selectedType == 1) {
          condition = "قبل الاكل";
        } else {
          condition = "بعد الاكل";
        }
        if (locator.dosesCounts == 1) {
          MedicineModel newMedicine = MedicineModel(
            count: locator.pellCount,
            name: event.name,
            before: condition,
            period: locator.pellPireod,
            time: locator.time.toString(),
            userId: userId,
            state: stateEnum.notYet,
            done: false,
            schedule: TimeOfDay.now().toString(),
          );
          await locator.insertMediationData(newMedicine);
        } else if (locator.dosesCounts == 2) {
          final name1 = "${event.name} - الجرعة الاولي";
          final name2 = "${event.name} - الجرعة الثانيه";
          MedicineModel new1Medicine = MedicineModel(
            count: locator.pellCount,
            name: name1,
            before: condition,
            period: locator.pellPireod,
            time: locator.time.toString(),
            userId: userId,
            state: stateEnum.notYet,
            done: false,
            schedule: TimeOfDay.now().toString(),
          );
          await locator.insertMediationData(new1Medicine);
          TimeOfDay time2 = locator.time.replacing(
            hour: (locator.time.hour + 12) %
                24, // Adding 12 hours and handling overflow
          );
          MedicineModel new2Medicine = MedicineModel(
            count: locator.pellCount,
            name: name2,
            before: condition,
            period: locator.pellPireod,
            time: time2.toString(),
            userId: userId,
            state: stateEnum.notYet,
            done: false,
            schedule: TimeOfDay.now().toString(),
          );
          await locator.insertMediationData(new2Medicine);
        } else if (locator.dosesCounts == 3) {
          final name1 = "${event.name} - الجرعة الاولي";
          final name2 = "${event.name} - الجرعة الثانيه";
          final name3 = "${event.name} - الجرعة الثالثة";

          MedicineModel new1Medicine = MedicineModel(
            count: locator.pellCount,
            name: name1,
            before: condition,
            period: locator.pellPireod,
            time: locator.time.toString(),
            userId: userId,
            state: stateEnum.notYet,
            done: false,
            schedule: TimeOfDay.now().toString(),
          );
          await locator.insertMediationData(new1Medicine);
          TimeOfDay time2 = locator.time.replacing(
            hour: (locator.time.hour + 12) %
                24, // Adding 12 hours and handling overflow
          );
          MedicineModel new2Medicine = MedicineModel(
            count: locator.pellCount,
            name: name2,
            before: condition,
            period: locator.pellPireod,
            time: time2.toString(),
            userId: userId,
            state: stateEnum.notYet,
            done: false,
            schedule: TimeOfDay.now().toString(),
          );
          await locator.insertMediationData(new2Medicine);

          TimeOfDay time3 = locator.time.replacing(
            hour: (locator.time.hour + 8) %
                24, // Adding 12 hours and handling overflow
          );
          MedicineModel new3Medicine = MedicineModel(
            count: locator.pellCount,
            name: name2,
            before: condition,
            period: locator.pellPireod,
            time: time3.toString(),
            userId: userId,
            state: stateEnum.notYet,
            done: false,
            schedule: TimeOfDay.now().toString(),
          );
          await locator.insertMediationData(new3Medicine);
        }
        emit(MedicineSuccessState(msg: "تمت إضافة الدواء بنجاح"));
      } catch (e) {
        emit(MedicineErrorState(msg: "حدث خطأ أثناء إضافة الدواء"));
      }
    } else {
      emit(MedicineErrorState(msg: "يرجى ملء جميع الحقول المطلوبة."));
    }
  }

  FutureOr<void> updateMedicine(
      MedicineUpdated event, Emitter<MedicineState> emit) async {
    if (event.medicine.name!.trim().isNotEmpty) {
      try {
        await locator.upDateMediationData(event.medicine, event.id);
        emit(MedicineLoadedState(list: listOfMedicine));
        emit(MedicineSuccessState(msg: "تم تحديث الدواء بنجاح"));
      } catch (e) {
        emit(MedicineErrorState(msg: "حدث خطأ أثناء تحديث الدواء"));
      }
    } else {
      emit(MedicineErrorState(msg: "يرجى ملء جميع الحقول المطلوبة."));
    }
  }

  FutureOr<void> deleteMedicine(
      MedicineDeleted event, Emitter<MedicineState> emit) async {
    try {
      await locator.deleteMediationData(event.medicine.id!);
      emit(MedicineLoadedState(list: listOfMedicine));
      emit(MedicineSuccessState(msg: "تم حذف الدواء بنجاح"));
    } catch (e) {
      emit(MedicineErrorState(msg: "حدث خطأ أثناء حذف الدواء"));
    }
  }

  FutureOr<void> changeRadio(
      ChangeRadioEvent event, Emitter<MedicineState> emit) {
    selectedType = event.num;
    emit(ChangeState());
  }
}
