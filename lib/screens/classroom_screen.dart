import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:teacher_app/components/digicampus_appbar.dart';
import 'package:teacher_app/models/timetable.dart';
import 'package:teacher_app/screens/discussions_screen.dart';
import 'package:teacher_app/states/teacher_state.dart';

class ClassroomScreen extends StatefulWidget {
  const ClassroomScreen({Key key}) : super(key: key);

  @override
  _ClassroomScreenState createState() => _ClassroomScreenState();
}


class _ClassroomScreenState extends State<ClassroomScreen> {
  ScrollController _scrollController = new ScrollController();
  var launchDate = DateTime(2020,06,08);
  DateTime lastDate;
  Firestore firestore = Firestore.instance;
  List<DocumentSnapshot> _items;
  // ScrollController _controller2;
  // double iconOffset;
  // double offset;
  // bool watchLive;

  // @override
  // void initState() {
  //   _controller1.addListener(() {
  //     setState(() {
  //       _controller1.notifyListeners();
  //     });
  //     // offset = _controller1.offset;
  //     // setState(() {
  //     //   _controller2.animateTo(offset,
  //     //       duration: Duration(microseconds: 400), curve: null);
  //     //   _controller2.notifyListeners();
  //     //   print(offset);
  //     // });
  //   });
  //   super.initState();
  // }

   @override
   void initState() {
     // iconOffset = 50.0;
     // watchLive = false;
     lastDate =  DateTime.now().add(Duration(days: 1));
     super.initState();
   }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget dateTiles(int i) {
    TeacherState teacherState =  Provider.of<TeacherState>(context, listen: true);
    print('DATETILES');
    DateFormat _dateFormat = DateFormat.yMMMd();
    DateFormat _dateFormatDay = DateFormat.E();
//    DateFormat _dateFormatSave = DateFormat.yMd();
    var date = lastDate.subtract(Duration(days: i));
    int hrs = 11;
    // print(hrs);
    // int mts = date.minute;
    String formattedDay = _dateFormatDay.format(date);
    String formattedDate = _dateFormat.format(date);
    String saveFormattedDate = DateFormat('dd-MM-yyyy').format(date);
//    bool isVideoUploaaded= false;
    var startTime = ['10:00','10:45','11:30'];
    var endTime = ['10:30','11:15','12:00'];
//    print('TIMETABLE : : : : ${TimeTable().getTeacherTimeTable(teacherState.teacher.teacherId)[0]['periods'][2]['class']}');

    List<Map<String, dynamic>> timeTableList = TimeTable().getTeacherTimeTable(teacherState.teacher.teacherId);
//    [
//      {
//        'day': 'Monday',
//        'periods': [{'pdno': 1, 'class': '7', 'startTime': '10:00', 'endTime': '10:30'},
//          {'pdno': 2, 'class': '8', 'startTime': '10:45', 'endTime': '11:15'},
//          {'pdno': 3, 'class': '7', 'startTime': '11:30', 'endTime': '12:00'}],
//      },
//      {
//        'day': 'Tuesday',
//        'periods': [{'pdno': 1, 'class': '7', 'startTime': '10:00', 'endTime': '10:30'},
//          {'pdno': 2, 'class': '8', 'startTime': '10:45', 'endTime': '11:15'},
//          {'pdno': 3, 'class': '9', 'startTime': '11:30', 'endTime': '12:00'}],
//      },
//      {
//        'day': 'Wednesday',
//        'periods': [{'pdno': 1, 'class': '8', 'startTime': '10:00', 'endTime': '10:30'},
//          {'pdno': 2, 'class': '7', 'startTime': '10:45', 'endTime': '11:15'},
//          {'pdno': 3, 'class': '9', 'startTime': '11:30', 'endTime': '12:00'}],
//      },
//      {
//        'day': 'Thursday',
//        'periods': [{'pdno': 1, 'class': '9', 'startTime': '10:00', 'endTime': '10:30'},
//          {'pdno': 2, 'class': '8', 'startTime': '10:45', 'endTime': '11:15'},
//          {'pdno': 3, 'class': '9', 'startTime': '11:30', 'endTime': '12:00'}],
//      },
//      {
//        'day': 'Friday',
//        'periods': [{'pdno': 1, 'class': '7', 'startTime': '10:00', 'endTime': '10:30'},
//          {'pdno': 2, 'class': '8', 'startTime': '10:45', 'endTime': '11:15'},
//          {'pdno': 3, 'class': '9', 'startTime': '11:30', 'endTime': '12:00'}],
//      },
//  ];
    print(timeTableList);
    Map<String, dynamic> timeTable;
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
        return Container();
    }
    print('num: ${timeTable['day']}');
    print('indexlength : ${timeTable['periods'].length}');
    // List<Widget> _periods = [];
    // for (int i = 0; i < 7; i++) _periods.add(periodWidgets(i, formattedDay));
    return Container(
        child: Column(children: [
      Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
              elevation: 8,
              color: Colors.grey[200],
              child: IntrinsicHeight(
                  child: Row(children: <Widget>[
                Container(
                  width: 60,
                  color: Colors.orange[200],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        formattedDate.substring(
                            4, (formattedDate[6] == ',') ? 6 : 5),
                        style: TextStyle(fontSize: 28),
                      ),
                      Text(
                        formattedDate.substring(0, 3),
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification scrollInfo) {
                      print('scrolling.... ${scrollInfo.metrics.pixels}');
                      _scrollController.jumpTo(scrollInfo.metrics.pixels);
                      return false;
                    },
                    child: SingleChildScrollView(
                      // controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                          Colors.grey[100].withOpacity(0.3),
                          Colors.grey[400].withOpacity(0.3)
                        ])),
                        child: Row(
                            children: List.generate(timeTable['periods'].length, (index) {
                          var isVideoUploaded = false;
                          var videoUrl = '';
                          return StreamBuilder<QuerySnapshot>(
                            stream: firestore.collection('grade_${timeTable['periods'][index]['class']}').snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData)
                                return Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Theme.of(context).primaryColor)));
                              else  {
                                _items = snapshot.data.documents;
                                if(_items.isNotEmpty)
                                _items.forEach((element) {
                                  if(timeTable['periods'][index]['class']==0)
                                    isVideoUploaded = false;
                                  else if(element.documentID == saveFormattedDate)
                                    if(element['period_${timeTable['periods'][index]['pdno']}']!=null)
                                      {
                                        print(element['period_${timeTable['periods'][index]['pdno']}']['videoUrl']);
                                        videoUrl = element['period_${timeTable['periods'][index]['pdno']}']['videoUrl'];
                                        print('KEY --->> TRUE');
                                        videoUrl != null
                                            ?isVideoUploaded = true
                                            :isVideoUploaded = false;
                                      }
                                    else  isVideoUploaded = false;
                                });
                              return Row(
                                    children: <Widget>[
                                      GestureDetector(
                                        behavior: HitTestBehavior.translucent,
                                        onTap: (){
                                          Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                                              DiscussionsScreen(date: saveFormattedDate, grade: timeTable['periods'][index]['class'].toString(), subject: timeTable['subject'], period: timeTable['periods'][index]['pdno'], uploadStatus: isVideoUploaded, url: videoUrl,)));
                                          print(hrs);
//                                  hrs == (9+index) && i == 0
//                                  ? Navigator.of(context).pushNamed('/live')
//                                  : Navigator.of(context).pushNamed('/discussions');
                                        },
                                        child: Container(
                                            height: 80,
                                            width: 100,
                                            decoration: BoxDecoration(
                                                gradient: isVideoUploaded
                                                    ? LinearGradient(colors: [
                                                        Colors.blue[
                                                            (index + 1) * 100],
                                                        Colors.blue[
                                                            100 + ((index + 1) * 100)]
                                                      ])
                                                    : null),
                                            // color: Colors.deepOrange[100+(index*100)],
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
//                                                    'Class : ',
                                                    timeTable['periods'][index]['class']==0?
                                                        'Free Period'
                                                    :'Class : ${timeTable['periods'][index]['class']}',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                    overflow: TextOverflow.clip,
                                                  ),
                                                  Text(
                                                    "${startTime[timeTable['periods'][index]['pdno']-1]} - ${endTime[timeTable['periods'][index]['pdno']-1]}",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                    overflow: TextOverflow.clip,
                                                  ),
                                                ],
                                              ),
                                            )),
                                      ),
                                      VerticalDivider(
                                        thickness: 1,
                                        width: 1,
                                        color: Colors.white,
                                      )
                                    ],
                                  );}
                            }
                          );}
                              )),
                      ),
                    ),
                  ),
                ),
              ]))))
    ]));
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _dateTileWidgets = [];
    print(launchDate.difference(DateTime.now()).inDays);
    for (int i = 0; i <= lastDate.difference(launchDate).inDays; i++) _dateTileWidgets.add(dateTiles(i));
    return Scaffold(
        body: Column(
      children: <Widget>[
        DigiCampusAppbar(
          icon: Icons.close,
          onDrawerTapped: () {
            Navigator.of(context).pop();
          },
          title: 'Virtual Classroom',
        ),
        SizedBox(height: 12),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0),
          height: 50,
          child: SingleChildScrollView(
            // controller: _controller2,
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            child: Container(
                height: 30,
                color: Colors.grey[300],
                alignment: Alignment.center,
                padding: EdgeInsets.only(left: 50),
                margin: EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
//                    children: List.generate(8, (index) {
//                  hr = 9 + index;
//                  return Row(
//                    children: <Widget>[Text('$hr:00'), SizedBox(width: 65)],
//                  );
//                })
                children: [
                  Text('10:00'), SizedBox(width: 65),
                  Text('10:45'), SizedBox(width: 65),
                  Text('11:30'), SizedBox(width: 65),
                  Text('12:00'), SizedBox(width: 65)
                ],
                )),
          ),
        ),
        Expanded(
            child: SingleChildScrollView(
                child: Column(
          children: _dateTileWidgets,
        ))),
      ],
    ));
  }
}
