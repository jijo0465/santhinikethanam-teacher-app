import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:teacher_app/components/digi_key_value_display.dart';
import 'package:teacher_app/components/digicampus_appbar.dart';

class TeacherProfileScreen extends StatelessWidget {
  final String teacherName;
  final int teacherId;
  const TeacherProfileScreen(
      {Key key, this.teacherName = 'Rachel', this.teacherId = 1011})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String displayTeacherId = teacherId.toString();
    displayTeacherId = 'T-' + displayTeacherId;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 35),
            height: 400,
            width: double.infinity,
            child: Image.asset(
              'assets/images/school.jpg',
              fit: BoxFit.fill,
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaY: 4, sigmaX: 4),
            child: Column(
              children: <Widget>[
                DigiCampusAppbar(
                  icon: Icons.home,
                  onDrawerTapped: () {
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(height: 6),
                Container(
                    alignment: Alignment.center,
                    child: Text(
                      ' $teacherName',
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        //backgroundColor: Colors.blue[800],
                        fontSize: 22,
                      ),
                    )),
                SizedBox(height: 6),
                Hero(
                  tag: 'studentdetails',
                  child: Container(
                    height: 150,
                    width: 150,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            alignment: Alignment.center,
                            fit: BoxFit.fill,
                            image: AssetImage('assets/images/sir.jpg'))),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Expanded(
                    child: Container(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 6),
                      Container(
                        child: Text(
                          'Teacher ID : $displayTeacherId',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 6),
                      DigiKeyValueDisplay(
                          textKey: 'Teacher Name',
                          textValue: 'Name',
                          textColor: Colors.white),
                      DigiKeyValueDisplay(
                          textKey: 'Class',
                          textValue: 'class',
                          textColor: Colors.white),
                      DigiKeyValueDisplay(
                          textKey: 'Subject',
                          textValue: 'subject',
                          textColor: Colors.white),
                      SizedBox(
                        height: 6,
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50))),
                  height: 120 - MediaQuery.of(context).padding.top,
                  width: MediaQuery.of(context).size.width,
                ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
