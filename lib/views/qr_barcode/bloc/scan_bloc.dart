import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:meta/meta.dart';
import 'package:medicine_reminder_app/service/api.dart';

part 'scan_event.dart';
part 'scan_state.dart';

class ScanBloc extends Bloc<ScanEvent, ScanState> {
  ScanBloc() : super(ScanInitial()) {
    on<ScanQR>(getData);
  }

  FutureOr<void> getData(ScanQR event, Emitter<ScanState> emit) async{
    try {
        String qrResult = await FlutterBarcodeScanner.scanBarcode(
            '#2A99CF', 'إلغاء', true, ScanMode.BARCODE);
        if (qrResult == '-1') {
          emit(ScanCanceled());
        } else {
          // Map<String , dynamic> result = await Api().fetchMedicationData(qrResult);
          emit(ScanSuccess(qrResult));
        }
      } catch (e) {
        emit(ScanFailure());
      }
  }
}
