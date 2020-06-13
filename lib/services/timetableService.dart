import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:teacher_app/models/timetable.dart';
import 'package:http/http.dart' as http;

class TimetableService{
  SharedPreferences _prfs;
  Future<TimeTable> getTeacherTimetable(String teacherId) async {
    _prfs = await SharedPreferences.getInstance();
    TimeTable timeTable;
    String url = 'http://localhost:8082/teachertime/teacherId';
//    String url = 'http://10.0.2.2:8080/digicampus/auth_api/parent_auth';
    Map<String, String> headers = {"Content-type": "application/json"};
//    Map<String, dynamic> params = {"loginId":parentId,"password":password,"userType":"STUDENT"};
//    String data = jsonEncode(params);
//    Teacher teacher;
    await http.get(url, headers: headers).then((response) async {
//      print((response.body));
      if (response.body != null) {
        final Map body = json.decode(response.body);
        print(body);
//        timeTable = TimeTable.fromMap(body);
//        await http.get('http://192.168.0.31:8080/getTeacherTimeTable/${teacher.id}',headers: headers).then((response){
////          final List<Map> body = json.decode(response.body);
//          print(response.body[0]);
//        });
////        }
      }
    }).catchError((error) => print(error));

    return timeTable;
  }

}