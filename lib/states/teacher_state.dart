import 'package:flutter/widgets.dart';
import 'package:teacher_app/models/student.dart';
import 'package:teacher_app/models/teacher.dart';

class TeacherState with ChangeNotifier {
  Teacher _teacher;
  List<Map<String,dynamic>> _timeTable;


  TeacherState.instance() {
    _timeTable = List();
//    DigiLocalSql().getAllStudents().then((value) {
//      _students = value;
//      setAllStudents(_students);
//    });
  }

  Teacher get teacher => _teacher;
  List<Map<String,dynamic>> get timeTable => _timeTable;

  setTeacher(Teacher teacher) async {
    this._teacher = teacher;
    notifyListeners();
  }

  setTimeTable(List<Map<String,dynamic>> timeTable) async {
    this._timeTable = timeTable;
    notifyListeners();
  }


}
