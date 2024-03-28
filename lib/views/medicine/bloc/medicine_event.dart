part of 'medicine_bloc.dart';

@immutable
sealed class MedicineEvent {}

class MedicineLoadEvent extends MedicineEvent {}

class ChangeRadioEvent extends MedicineEvent {
  final int num;

  ChangeRadioEvent({required this.num});
  
}

class MedicineAdded extends MedicineEvent {
  final String name;

  MedicineAdded({required this.name});

}

class MedicineDeleted extends MedicineEvent {
  final MedicineModel medicine;

  MedicineDeleted({required this.medicine});
}

class MedicineUpdated extends MedicineEvent {
  final MedicineModel medicine;
  final String id;
  final MedicineModel currentMedicine;

  MedicineUpdated({required this.medicine, required this.id, required this.currentMedicine});
}
