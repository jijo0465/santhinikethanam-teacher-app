import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teacher_app/models/teacher.dart';
import 'package:teacher_app/services/digi_auth.dart';
import 'package:teacher_app/states/teacher_state.dart';
import 'package:teacher_app/models/timetable.dart';
enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }


class LoginState with ChangeNotifier {
  static Status _status = Status.Uninitialized;
  SharedPreferences _prfs;

  LoginState.instance();

  Status get status => _status;

  Future<bool> signIn(String teacherId, String password, TeacherState teacherState) async {
    _status = Status.Authenticating;
    notifyListeners();
    DigiAuth digiAuth = DigiAuth();
    Teacher teacher = await digiAuth.signIn(teacherId, password);
    if(teacher!=null){
      teacherState.setTeacher(teacher);
//      TimeTable timeTable = TimeTable();
//      List<Map<String, dynamic>> timeTableList = timeTable.getTeacherTimeTable(teacher.teacherId);
//      teacherState.setTimeTable(timeTableList);
      _status = Status.Authenticated;
      _prfs = await SharedPreferences.getInstance();
      print('GIGUIguUHUHUHu');
      print(teacher.teacherId);
      print(json.encode(teacher));
      await _prfs.setBool('loggedIn',true);
      await _prfs.setString('teacher', json.encode(teacher));
      notifyListeners();
    }else{
      print('teacher is null');
      _status = Status.Unauthenticated;
      _prfs = await SharedPreferences.getInstance();
      await _prfs.setBool('loggedIn',false);
      notifyListeners();
    }

    return true;
  }

  Future signOut() async {
    _status = Status.Unauthenticated;
    notifyListeners();
    _prfs = await SharedPreferences.getInstance();
    _prfs.setBool('loggedIn',false);  
  }
  Future<bool> setStatus(Status _statusUpdate) async {
    _status = _statusUpdate;
    notifyListeners();
    return true;
  }
}
