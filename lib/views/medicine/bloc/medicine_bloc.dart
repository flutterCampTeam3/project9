import 'dart:async';

import 'package:bloc/bloc.dart';
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
    if (event.medicine.name!.trim().isNotEmpty) {
      try {
        await locator.insertMediationData(event.medicine);
        emit(MedicineLoadedState(list: listOfMedicine));
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



  FutureOr<void> changeRadio(ChangeRadioEvent event, Emitter<MedicineState> emit) {
    selectedType = event.num;
    emit(ChangeState());
  }
}
