import 'package:flutter/material.dart';
import 'package:teacher_app/components/digi_graph_chart.dart';
import 'package:teacher_app/components/digi_subject_bar.dart';
import 'package:teacher_app/components/digicampus_appbar.dart';
import 'package:teacher_app/components/select_class.dart';
import 'package:teacher_app/components/select_division.dart';
import 'package:teacher_app/components/select_student.dart';

enum Subjects { All, Mathematics, English, Social, Science, Malayalam, Hindi }

class StudentResult extends StatefulWidget {
  const StudentResult({Key key}) : super(key: key);

  @override
  _StudentResultState createState() => _StudentResultState();
}

class _StudentResultState extends State<StudentResult> {
  Subjects selectedSubject = Subjects.All;
  static List<String> titleList = [
    'Overall Performance',
    'Maths',
    'English',
    'Social',
    'Science',
    'Malayalam',
    'Hindi'
  ];
  String title = titleList.first;
  //String percentTitle = titleList.first;
  int subjectIndex = 0;
  double percentValue = 0.95;
  double percentage;
  bool showTimeline = false;
  bool isLoading = false;
  ScrollController _controller;
  int grade = 0;
  int division = 0;
  int student = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          DigiCampusAppbar(
            icon: Icons.close,
            onDrawerTapped: () {
              Navigator.of(context).pop();
            },
          ),
          Column(children: <Widget>[
            SizedBox(height:100),
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
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 30),
                          Container(
                            height: MediaQuery.of(context).size.height,
                            child: Column(children: <Widget>[
                              // AnimatedPadding(
                              //     padding: EdgeInsets.only(
                              //         top: showTimeline
                              //             ? 60 - MediaQuery.of(context).padding.top
                              //             : 100),
                              //     duration: Duration(milliseconds: 400)),
                              // DigiScreenTitle(text: 'Academic Performances'),
                              // SizedBox(height: 12),
                              // Container(
                              //   margin: EdgeInsets.only(left: 5),
                              //     child: LinearPercentIndicator(
                              //   percent: 0.9,
                              //   center: Text(title + '\t:\t$percentage%',
                              //       style: TextStyle(fontSize: 12.0)),
                              //   width: MediaQuery.of(context).size.width - 10,
                              //   lineHeight: 15.0,
                              //   animation: true,
                              //   animationDuration: 600,
                              //   backgroundColor: Colors.grey,
                              //   progressColor: (percentValue >= 0.90)
                              //       ? Colors.green[900]
                              //       : (percentValue >= 0.80
                              //           ? Colors.green[700]
                              //           : (percentValue >= 0.70)
                              //               ? Colors.orangeAccent
                              //               : (percentValue >= 0.60)
                              //                   ? Colors.yellow[400]
                              //                   : Colors.red),
                              // )),
                              Container(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  //height: 500,
                                  width: MediaQuery.of(context).size.width,
                                  child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: List.generate(7, (index) {
                                          return DigiSubjectBar(
                                            index: index,
                                            isSelected: index == subjectIndex,
                                            onPressed: () {
                                              title =
                                                  titleList.elementAt(index);
                                              switch (index) {
                                                case 0:
                                                  setState(() {
                                                    selectedSubject =
                                                        Subjects.All;
                                                    subjectIndex = 0;
                                                  });
                                                  break;
                                                case 1:
                                                  setState(() {
                                                    selectedSubject =
                                                        Subjects.Mathematics;
                                                    subjectIndex = 1;
                                                  });
                                                  break;
                                                case 2:
                                                  setState(() {
                                                    selectedSubject =
                                                        Subjects.English;
                                                    subjectIndex = 2;
                                                  });
                                                  break;
                                                case 3:
                                                  setState(() {
                                                    selectedSubject =
                                                        Subjects.Social;
                                                    subjectIndex = 3;
                                                  });
                                                  break;
                                                case 4:
                                                  setState(() {
                                                    selectedSubject =
                                                        Subjects.Science;
                                                    subjectIndex = 4;
                                                  });
                                                  break;
                                                case 5:
                                                  setState(() {
                                                    selectedSubject =
                                                        Subjects.Malayalam;
                                                    subjectIndex = 5;
                                                  });
                                                  break;
                                                case 6:
                                                  setState(() {
                                                    selectedSubject =
                                                        Subjects.Hindi;
                                                    subjectIndex = 6;
                                                  });
                                                  break;
                                              }
                                            },
                                          );
                                        }),
                                      ))),
                              //SizedBox(height: 12),
                              Container(
                                  margin: EdgeInsets.only(top: 12),
                                  height: 24,
                                  alignment: Alignment.topCenter,
                                  child: Text(
                                    title,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        //backgroundColor: Colors.black26,
                                        color: Colors.blue[900]),
                                  )),
                              Container(
                                margin: EdgeInsets.only(top: 10, bottom: 10),
                                height: 300,
                                width: (MediaQuery.of(context).size.width) - 20,
                                child: Charts(index: subjectIndex),
                              ),
                              SizedBox(height: 12),
                            ]),
                          ),
                        ],
                      ),
                    ),
                  ),
          ])
        ],
      ),
    );
  }
}
