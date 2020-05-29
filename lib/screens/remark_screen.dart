import 'package:flutter/material.dart';
import 'package:teacher_app/components/digicampus_appbar.dart';
import 'package:teacher_app/components/select_class.dart';
import 'package:teacher_app/components/select_division.dart';
import 'package:teacher_app/components/select_student.dart';

class RemarkScreen extends StatefulWidget {
  const RemarkScreen({Key key}) : super(key: key);

  @override
  _RemarkScreenState createState() => _RemarkScreenState();
}

class _RemarkScreenState extends State<RemarkScreen> {
  int grade = 0;
  int division = 0;
  int student = 0;
  bool showTimeline = false;

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(height: 120),
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
                  : Column(
                      children: <Widget>[
                        SizedBox(height: 30),
                        Container(
                          height: 150,
                          width: 280,
                          child: Stack(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(top: 15),
                                child: TextFormField(
                                  minLines: 3,
                                  maxLines: 5,
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          borderSide:
                                              BorderSide(color: Colors.black)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          borderSide:
                                              BorderSide(color: Colors.blue))),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                    color: Colors.white,
                                    height: 30,
                                    width: 100,
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Remarks',
                                      style: TextStyle(fontSize: 18),
                                    )),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 100,
                          child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(10.0)),
                              color: Theme.of(context).primaryColor,
                              onPressed: () {},
                              child: Text(
                                'submit',
                                style: TextStyle(color: Colors.white),
                              )),
                        )
                      ],
                    ),
              SizedBox(height: 20),
            ],
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            top: showTimeline ? 180 : MediaQuery.of(context).size.height - 48,
            child: Column(children: <Widget>[
              GestureDetector(
                onVerticalDragStart: (details) {
                  setState(() {
                    showTimeline = !showTimeline;
                  });
                },
                onTap: () {
                  setState(() {
                    showTimeline = !showTimeline;
                  });
                },
                child: Container(
                  height: 45,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          color.withOpacity(0.8),
                          color,
                          color.withOpacity(0.9)
                        ],
                      ),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50))),
                  alignment: Alignment.topCenter,
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15))),
                      padding: EdgeInsets.only(left: 12, right: 12),
                      height: 40,
                      width: 120,
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text('History',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.red[300],
                                )),
                          ])),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      color.withOpacity(0.8),
                      color,
                      color.withOpacity(0.8)
                    ],
                  ),
                ),
                width: (MediaQuery.of(context).size.width),
                height: MediaQuery.of(context).size.height - 120 - 30 - 12,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 14, right: 14),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 130,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          elevation: 2,
                          color: Colors.white,
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: Text('Remarks:'),
                              ),
                              SizedBox(height: 60),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 14, right: 14),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    children: <Widget>[
                                      Divider(
                                        color: Colors.grey[500],
                                        thickness: 1.5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                              child: Text(
                                            '11/06/2020',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.blue),
                                          )),
                                          Container(
                                              child: Text(
                                            'VII A',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.blue),
                                          )),
                                          Container(
                                              child: Text(
                                            'Jon Snow',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.blue),
                                          )),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ]),
          ),
          DigiCampusAppbar(
            icon: Icons.close,
            onDrawerTapped: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
