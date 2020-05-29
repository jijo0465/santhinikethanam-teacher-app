import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

class AttendanceTable extends StatefulWidget {
  final ValueChanged<bool> onChanged;
  const AttendanceTable({Key key, this.onChanged}) : super(key: key);

  @override
  _AttendanceTableState createState() => _AttendanceTableState();
}

class _AttendanceTableState extends State<AttendanceTable> {
  bool val1 = false;
  bool val2 = false;
  bool val3 = false;
  bool val4 = false;
  bool val;
  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = TextStyle(
        fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
          columnSpacing: 25,
          columns: [
            DataColumn(
                label: Text(
              'Roll No',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  color: Colors.white),
            )),
            DataColumn(
                label: Text('Name',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        color: Colors.white))),
            DataColumn(
                label: Container(
              padding: EdgeInsets.only(left: 25),
              child: Text('Attendance',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      color: Colors.white)),
            ))
          ],
          rows: names
              .map((name) => DataRow(cells: [
                    DataCell(
                      Text(
                        name.rollNo,
                        style: textStyle,
                      ),
                    ),
                    DataCell(Text(
                      name.sname,
                      style: textStyle,
                    )),
                    DataCell(
                      Container(
                        child: Transform.scale(
                          child: LiteRollingSwitch(
                            animationDuration: Duration(milliseconds: 250),
                            value: true,
                            textOn: 'Present',
                            textOff: 'Absent',
                            textSize: 18,
                            colorOn: Colors.green,
                            colorOff: Colors.red,
                            iconOn: Icons.thumb_up,
                            iconOff: Icons.thumb_down,
                            onChanged: widget.onChanged,
                          ),
                          scale: 0.5,
                        ),
                      ),
                    ),
                  ]))
              .toList()),
    );
  }
}

class Name {
  String rollNo;
  String sname;
  Name({this.rollNo, this.sname});
}

var names = <Name>[
  Name(rollNo: '01', sname: 'Abhijith'),
  Name(rollNo: '02', sname: 'Abhishek'),
  Name(rollNo: '03', sname: 'Arjun'),
  Name(rollNo: '04', sname: 'Irene'),
  Name(rollNo: '05', sname: 'Janet'),
];
