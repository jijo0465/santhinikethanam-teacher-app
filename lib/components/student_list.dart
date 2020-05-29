import 'package:flutter/material.dart';

class StudentList extends StatefulWidget {
  const StudentList({Key key}) : super(key: key);

  @override
  _StudentListState createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  bool _val1 = false;
  bool _val2 = false;
  bool _val3 = false;
  bool _val4 = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(columnSpacing: 28, columns: [
        DataColumn(
            label: Text(
          'Roll No',
          style: TextStyle(
              fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black),
        )),
        DataColumn(
            label: Text('Name',
                style: TextStyle(fontSize: 14, color: Colors.black))),
        DataColumn(
            label: Container(
          padding: EdgeInsets.only(left: 25),
          child: Text('select',
              style: TextStyle(fontSize: 14, color: Colors.black)),
        ))
      ], rows: [
        DataRow(cells: [
          DataCell(
              Text('01', style: TextStyle(fontSize: 14, color: Colors.black))),
          DataCell(Text('Aaromal',
              style: TextStyle(fontSize: 14, color: Colors.black))),
          DataCell(Padding(
            padding: const EdgeInsets.only(left: 14),
            child: Container(
                child: Checkbox(
              value: _val1,
              onChanged: (bool value) {
                setState(() {
                  _val1 = value;
                });
              },
              activeColor: Colors.blue,
            )),
          ))
        ]),
        DataRow(cells: [
          DataCell(
              Text('02', style: TextStyle(fontSize: 14, color: Colors.black))),
          DataCell(Text('Abhijith',
              style: TextStyle(fontSize: 14, color: Colors.black))),
          DataCell(Padding(
            padding: const EdgeInsets.only(left: 14),
            child: Container(
                child: Checkbox(
              value: _val2,
              onChanged: (bool value) {
                setState(() {
                  _val2 = value;
                });
              },
              activeColor: Colors.blue,
            )),
          ))
        ]),
        DataRow(cells: [
          DataCell(
              Text('03', style: TextStyle(fontSize: 14, color: Colors.black))),
          DataCell(Text('Abhil',
              style: TextStyle(fontSize: 14, color: Colors.black))),
          DataCell(Padding(
            padding: const EdgeInsets.only(left: 14),
            child: Container(
                child: Checkbox(
              value: _val3,
              onChanged: (bool value) {
                setState(() {
                  _val3 = value;
                });
              },
              activeColor: Colors.blue,
            )),
          ))
        ]),
        DataRow(cells: [
          DataCell(
              Text('04', style: TextStyle(fontSize: 14, color: Colors.black))),
          DataCell(Text('Abhirag',
              style: TextStyle(fontSize: 14, color: Colors.black))),
          DataCell(Padding(
            padding: const EdgeInsets.only(left: 14),
            child: Container(
                child: Checkbox(
              value: _val4,
              onChanged: (bool value) {
                setState(() {
                  _val4 = value;
                });
              },
              activeColor: Colors.blue,
            )),
          ))
        ]),
      ]),
    );
  }
}
