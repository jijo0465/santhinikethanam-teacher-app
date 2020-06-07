import 'package:flutter/widgets.dart';
import 'package:teacher_app/models/student.dart';
import 'package:teacher_app/models/teacher.dart';

class TeacherState with ChangeNotifier {
  Teacher _teacher;



  TeacherState.instance() {
//    DigiLocalSql().getAllStudents().then((value) {
//      _students = value;
//      setAllStudents(_students);
//    });
  }

  Teacher get teacher => _teacher;

  setTeacher(Teacher teacher) async {
    this._teacher = teacher;
    notifyListeners();
  }


}
