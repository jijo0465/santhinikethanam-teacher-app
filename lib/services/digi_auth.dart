import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:teacher_app/models/teacher.dart';

class DigiAuth{
  SharedPreferences _prfs;
  Future<Teacher> signIn(String parentId, String password) async {
    _prfs = await SharedPreferences.getInstance();
    Teacher parent;
    String url = 'http://192.168.0.31:8080/validate';
//    String url = 'http://10.0.2.2:8080/digicampus/auth_api/parent_auth';
    Map<String, String> headers = {"Content-type": "application/json"};
    Map<String, dynamic> params = {"loginId":parentId,"password":password,"userType":"STUDENT"};
    String data = jsonEncode(params);
    print(jsonEncode(params));
    Teacher teacher;
    await http.post(url, headers: headers, body: data).then((response) {

      if (response.body != null) {
        final Map body = json.decode(response.body);
        print(body);
//        if(body['response']=='ok'){

        teacher = Teacher.fromMap(body);
//        }
      }
    }).catchError((error) => print(error));

    return teacher;
  }
}