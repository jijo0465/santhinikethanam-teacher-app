import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:teacher_app/models/timetable.dart';
import 'package:teacher_app/states/teacher_state.dart';

class DigiPeriodCard extends StatefulWidget {
  DigiPeriodCard({Key key}) : super(key: key);

  @override
  _DigiPeriodCardState createState() => _DigiPeriodCardState();
}

class _DigiPeriodCardState extends State<DigiPeriodCard> {
  PageController _pageController;
  Map<String,dynamic> timeTable;
  DateFormat dateFormat = DateFormat.E();
  var date = DateTime.now();

  @override
  void initState() {
    _pageController = PageController(initialPage: 0, viewportFraction: 0.9);
    super.initState();
  }

  int getGrade(int index) {
    TeacherState teacherState =  Provider.of<TeacherState>(context, listen: true);
    List<Map<String, dynamic>> timeTableList = TimeTable().getTeacherTimeTable(teacherState.teacher.teacherId);
    String formattedDay = dateFormat.format(date);
    print(formattedDay);
    switch (formattedDay) {
      case 'Mon':
        timeTable = timeTableList[0];
        break;
      case 'Tue':
        timeTable = timeTableList[1];
        break;
      case 'Wed':
        timeTable = timeTableList[2];
        break;
      case 'Thu':
        timeTable = timeTableList[3];
        break;
      case 'Fri':
        timeTable = timeTableList[4];
        break;
      default:
        timeTable = null;
    }
    print(timeTable);
    return timeTable['periods'][index]['class'];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: <Widget>[
          PageView.builder(
            controller: _pageController,
            itemCount: 3,
            itemBuilder: (BuildContext context, int index) {
              int grade = getGrade(index);
              return Container(
                margin: EdgeInsets.only(left: 2, right: 2),
                child: Card(
                  elevation: 8,
                  color: Colors.blue[100].withOpacity(0.6),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          child: Text(
                        'Time Table',
                        style: TextStyle(fontSize: 12),
                      )),
                      grade == 0
                      ?Container(
                          child: Text('Period : ${index+1}   Free',
                              style: TextStyle(fontSize: 18)))
                      :Container(
                          child: Text('Period : ${index+1}   Class : $grade',
                              style: TextStyle(fontSize: 18)))
                    ],
                  ),
                ),
              );
            },
          ),
          Positioned(
              left: 30,
              child: GestureDetector(
                onTap: () {
                  _pageController.previousPage(
                      duration: Duration(milliseconds: 600),
                      curve: Curves.fastLinearToSlowEaseIn);
                },
                child: Container(
                  height: 60,
                  child: Icon(
                    CupertinoIcons.left_chevron,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              )),
          Positioned(
              right: 30,
              child: GestureDetector(
                onTap: () {
                  _pageController.nextPage(
                      duration: Duration(milliseconds: 600),
                      curve: Curves.fastLinearToSlowEaseIn);
                },
                child: Container(
                  height: 60,
                  child: Icon(
                    CupertinoIcons.right_chevron,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
