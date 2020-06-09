import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teacher_app/models/teacher.dart';
import 'package:teacher_app/screens/home_screen.dart';
import 'package:teacher_app/screens/loading_screen.dart';
import 'package:teacher_app/screens/login_screen.dart';
import 'package:teacher_app/states/login_state.dart';
import 'package:teacher_app/states/teacher_state.dart';

class Redirect extends StatefulWidget {
  const Redirect({Key key}) : super(key: key);

  @override
  _RedirectState createState() => _RedirectState();
}

class _RedirectState extends State<Redirect> {
  bool _loginStatus = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TeacherState teacherState = Provider.of<TeacherState>(context, listen: false);
    return Consumer<LoginState>(
        builder: (BuildContext context, LoginState value, Widget child) {
      if (value.status==Status.Uninitialized) {
        SharedPreferences.getInstance().then((prefs) async {
          _loginStatus = prefs.getBool('loggedIn');
          if (_loginStatus == true) {
            String st = (await SharedPreferences.getInstance()).getString('teacher');
            print("STGGGGG   $st");
            Map<String,dynamic> teacherMap = json.decode(st);
            Teacher teacher = Teacher.fromMap(teacherMap);
            teacherState.setTeacher(teacher);
            value.setStatus(Status.Authenticated);
          }else{
            value.setStatus(Status.Unauthenticated);
          }
        });
      }
      switch (value.status) {
        case Status.Uninitialized:
          return LoadingScreen();
          break;
        case Status.Unauthenticated:
          return LoginScreen();
          break;
        case Status.Authenticating:
          return LoadingScreen();
          break;
        case Status.Authenticated:
          return HomeScreen();
          break;
      }
      return Container();
    });
  }
}
