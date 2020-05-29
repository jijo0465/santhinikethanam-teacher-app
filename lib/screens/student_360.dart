import 'package:flutter/material.dart';
import 'package:nima/nima_actor.dart';
import 'package:syncfusion_flutter_core/core.dart';
import 'package:teacher_app/components/digi_guage.dart';

import 'package:teacher_app/components/digicampus_appbar.dart';
import 'package:teacher_app/components/select_class.dart';
import 'package:teacher_app/components/select_division.dart';
import 'package:teacher_app/components/select_student.dart';

class Student360Screen extends StatefulWidget {
  const Student360Screen({Key key}) : super(key: key);

  @override
  _Student360ScreenState createState() => _Student360ScreenState();
}

class _Student360ScreenState extends State<Student360Screen> {
  int grade = 0;
    int division = 0;
    int student = 0;
  @override
  Widget build(BuildContext context) {
    
    SyncfusionLicense.registerLicense(
        'NT8mJyc2IWhia31ifWN9Z2FoYmF8YGJ8ampqanNiYmlmamlmanMDHmg5Ojk8Y2dlZhM0PjI6P30wPD4=');
    return Scaffold(
      body: Stack(
        children: <Widget>[
         Container(color: Theme.of(context).primaryColor.withOpacity(0.15)),
          DigiCampusAppbar(
            icon: Icons.close,
            onDrawerTapped: () {
              Navigator.of(context).pop();
            },
          ),
          Column(
            children: <Widget>[
              SizedBox(height: 110),
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 50),
                      child: Text(
                        'Select Class',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Container(
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(
                              color: Colors.blue,
                              style: BorderStyle.solid,
                              width: 0.80),
                        ),
                        padding: EdgeInsets.only(left: 20),
                        child: SelectClass(
                          onchanged: (value) {
                            division = 0;
                            student = 0;
                            print(value);
                            setState(() {
                              grade = value;
                            });
                          },
                          grade: grade,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10),
              grade == 0
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Row(
                        children: <Widget>[
                          Container(
                              padding: EdgeInsets.only(left: 50),
                              child: Text(
                                'Select Division',
                                style: TextStyle(fontSize: 18),
                              )),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                border: Border.all(
                                    color: Colors.blue,
                                    style: BorderStyle.solid,
                                    width: 0.80),
                              ),
                              padding: EdgeInsets.only(left: 20),
                              child: SelectDivision(
                                onchanged: (value) {
                                  student = 0;
                                  setState(() {
                                    division = value;
                                  });
                                },
                                division: division,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
              SizedBox(height: 10),
              division == 0
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Row(
                        children: <Widget>[
                          Container(
                              padding: EdgeInsets.only(left: 50),
                              child: Text(
                                'Select Student',
                                style: TextStyle(fontSize: 18),
                              )),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                border: Border.all(
                                    color: Colors.blue,
                                    style: BorderStyle.solid,
                                    width: 0.80),
                              ),
                              padding: EdgeInsets.only(left: 16),
                              child: SelectStudent(
                                onchanged: (value) {
                                  setState(() {
                                    student = value;
                                  });
                                },
                                student: student,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
              student == 0
                  ? Container()
                  : Expanded(
                    child: Stack(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Expanded(child: Container(),),
                            Container(
                              height: 210,
                              width: MediaQuery.of(context).size.width,
                              child: NimaActor(
                                'assets/animations/superman-podium.nma',
                                fit: BoxFit.fitHeight,
                                animation: 'Untitled',
                              ),
                            ),
                            Expanded(child: Container(),),
                          ],
                        ),
                        Positioned(
                          top: 10,
                          left: 15,
                          child: Container(
                            height: 140,
                            width: 140,
                            child: DigiGauge(
                              value: 90,
                              text: 'Academics',
                            ),
                          ),
                        ),
                        Positioned(
                          top: 10,
                          right: 15,
                          child: Container(
                            height: 140,
                            width: 140,
                            child: DigiGauge(
                              value: 70,
                              text: 'Sports',
                            ),
                          ),
                        ),
                        Positioned(
                          top: 165,
                          left: 0,
                          child: Container(
                            height: 110,
                            width: 110,
                            child: DigiGauge(
                              value: 50,
                              text: 'Consistency',
                            ),
                          ),
                        ),
                        Positioned(
                          top: 165,
                          right: 0,
                          child: Container(
                            height: 110,
                            width: 110,
                            child: DigiGauge(
                              value: 62,
                              text: 'Attendance',
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 25,
                          left: 12,
                          child: Container(
                            height: 140,
                            width: 140,
                            child: DigiGauge(
                              value: 88,
                              text: 'Language',
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 25,
                          right: 12,
                          child: Container(
                            height: 140,
                            width: 140,
                            child: DigiGauge(
                              value: 90,
                              text: 'Extra Curriculum',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
            ],
          ),
        ],
      ),
    );
  }
}
