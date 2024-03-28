import 'dart:async';

import 'package:flutter/material.dart';
import 'package:medicine_reminder_app/model/medicine_model.dart';
import 'package:medicine_reminder_app/model/scan_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DBServices {
  //supabase client
  final supabase = Supabase.instance.client;
  int pellCount = 0;
  int dosesCounts = 0;
  int pellPireod = 0;
  String typeat = "قبل الاكل ";

  TimeOfDay time = TimeOfDay.now();
  String email = "";
  String nameUser = "بك";

  // ----- Auth ------

  //Sign up
  Future signUp({required String email, required String password}) async {
    await supabase.auth.signUp(
      password: password,
      email: email,
    );
  }

  //create user
  Future createUser({required String name, required String email}) async {
    await supabase.from('user').insert({'email': email, 'username': name});
    nameUser = name;
  }

  Future getUser({required String id}) async {
    var userInfo =
        await supabase.from('user').select('*').match({'id': id}).single();
    nameUser = userInfo['username'];
  }

  // parCode Read and get the data
  Future getScanData({required String code}) async {
    print("before------------------");
    var ScanInfo =
        await supabase.from('scan').select('*').eq('code', code).single();
    print("data");
    // ScanInfo["name"];
    final medInfo = ScanModel.fromJson(ScanInfo);
    print("code------------------");
    print("code------------------ ${ScanInfo["name"]}");
    return medInfo;
  }

  //Login
  Future login({required String email, required String password}) async {
    await supabase.auth.signInWithPassword(password: password, email: email);
    final userId = await getCurrentUserId();
    await getUser(id: userId);
  }

  //Logout
  Future logout() async {
    supabase.auth.signOut();
  }

  //get current session
  Future getCurrentSession() async {
    final session = supabase.auth.currentSession;
    if (session != null) {
      return session;
    } else {
      return;
    }
  }

  //get current session
  Future getCurrentUserId() async {
    final session = supabase.auth.currentSession!.user.id;
    return session;
  }

  //reset password
  Future resetPassword({required String email}) async {
    await supabase.auth.resetPasswordForEmail(
      email,
    );
  }

  //send OTP
  Future sendOtp({required String email}) async {
    await supabase.auth.signInWithOtp(
      email: email,
      shouldCreateUser: false,
    );
  }

  //verify OTP
  Future verifyOtp({required String email, required String otpToken}) async {
    await supabase.auth
        .verifyOTP(token: otpToken, type: OtpType.email, email: email);
  }

  Future resend() async {
    email = supabase.auth.currentSession!.user.email!;
    await supabase.auth.resend(type: OtpType.signup, email: email);
  }

  //Update user
  Future changePassword({required String password}) async {
    await supabase.auth.updateUser(UserAttributes(password: password));
  }

  Future<List<MedicineModel>> getAllMedicine() async {
    final medicineListData = await supabase
        .from('mediction')
        .select('*')
        .match({'user_id': supabase.auth.currentUser!.id});
    List<MedicineModel> listOfMedicine = [];
    for (var element in medicineListData) {
      listOfMedicine.add(MedicineModel.fromJson(element));
    }
    return listOfMedicine;
  }

  //insert medication
  Future insertMediationData(MedicineModel medicine) async {
    final res = await supabase.from('mediction').insert({
      'user_id': medicine.userId,
      'time': medicine.time!.substring(9, 15),
      'count': medicine.count,
      'piriod': medicine.period,
      'name': medicine.name,
      'before': medicine.before,
      'stats': medicine.state.toString(),
      'done': false,
      'scheduling': TimeOfDay.now().toString().substring(9, 15),
    });
  }

  //update medication
  Future upDateMediationData(MedicineModel medicine, String id) async {
    final userID = await getCurrentUserId();
    print("in the ub func");
    await supabase.from('mediction').update({
      'user_id': userID,
      'time': medicine.time!.substring(9, 15),
      'count': medicine.count,
      'piriod': medicine.period,
      'name': medicine.name,
      'before': medicine.before,
      'done': medicine.done,
      'scheduling': medicine.schedule!,
      'stats': medicine.state.toString()
    }).eq("id", id);
    print("in the add func after the ub ");
  }

  //update state
  Future upDateState(String state, String id) async {
    print("in the update func");
    await supabase.from('mediction').update({
      'done': true,
      'stats': state,
    }).eq("id", id);
    print("in the update func after the ub ");
  }

  //delete medication
  Future deleteMediationData(String id) async {
    print("in the delet func");
    await supabase.from('mediction').delete().eq("id", id);
    print("in the no func");
  }
}
