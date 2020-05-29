import 'package:flutter/material.dart';
import 'package:teacher_app/components/attendance_table.dart';
import 'package:teacher_app/components/date_picker.dart';
import 'package:teacher_app/components/digicampus_appbar.dart';

class AttendanceHistory extends StatefulWidget {
  const AttendanceHistory({Key key}) : super(key: key);

  @override
  _AttendanceHistoryState createState() => _AttendanceHistoryState();
}

class _AttendanceHistoryState extends State<AttendanceHistory> {
  DateTime selectDate=DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 120),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                        child: Text(
                      'Select date',
                      style: TextStyle(fontSize: 16),
                    )),
                    Container(child: DatePicker(
                      selectedDate: selectDate,
                      daySelect: (value){
                        setState(() {
                          selectDate=value;
                        });
                      },
                    )),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50))),
                    padding: EdgeInsets.all(12),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: AttendanceTable(
                        onChanged: (bool state){
                           print('turned ${(state) ? 'on' : 'off'}');
                        },
                      ),
                    )),
              ],
            ),
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
