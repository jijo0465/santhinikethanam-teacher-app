import 'package:flutter/material.dart';
import 'package:teacher_app/components/digicampus_appbar.dart';

class UpcomingExams extends StatefulWidget {
  const UpcomingExams({Key key}) : super(key: key);

  @override
  _UpcomingExamsState createState() => _UpcomingExamsState();
}

class _UpcomingExamsState extends State<UpcomingExams> {
  var value = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(height: 120),
              Stack(
                children: <Widget>[
                  Center(
                    child: Container(
                      width: 300,
                      height: 70,
                      padding: EdgeInsets.only(top: 10),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            value = !value;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  color: Colors.grey[400], width: 1.5)),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(90, 20, 0, 0),
                            child: Container(child: Text('1st MID TERM',
                                style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),
                            )),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                        width: 100,
                        color: Colors.white,
                        child: Center(
                            child: Text(
                          '02-07-2020',
                          style: TextStyle(fontSize: 16),
                        ))),
                  )
                ],
              ),
              !value
                  ? Container()
                  : Container(
                      child: DataTable(columns: [
                        DataColumn(
                            label: Text(
                          'date',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 20),
                        )),
                        DataColumn(
                            label: Text(
                          'Subject',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 20),
                        ))
                      ], rows: [
                        DataRow(cells: [
                          DataCell(Text('02/07/2020')),
                          DataCell(Text('Engilsh'))
                        ]),
                        DataRow(cells: [
                          DataCell(Text('03/07/2020')),
                          DataCell(Text('Maths'))
                        ]),
                        DataRow(cells: [
                          DataCell(Text('04/07/2020')),
                          DataCell(Text('Social'))
                        ]),
                        DataRow(cells: [
                          DataCell(Text('05/07/2020')),
                          DataCell(Text('Hindi'))
                        ]),
                        DataRow(cells: [
                          DataCell(Text('06/07/2020')),
                          DataCell(Text('Science'))
                        ]),
                      ]),
                    ),
              SizedBox(
                height: 20,
              ),
              Stack(
                children: <Widget>[
                  Center(
                    child: Container(
                      width: 300,
                      height: 70,
                      child: GestureDetector(
                        onTap: () {
                          print('tapped');
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    color: Colors.grey[400], width: 1.5)),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(90, 20, 0, 0),
                              child: Container(
                                  child: Text(
                                '1st MID TERM',
                                style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),
                              )),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                        width: 100,
                        color: Colors.white,
                        child: Center(
                            child: Text(
                          '02-07-2020',
                          style: TextStyle(fontSize: 16),
                        ))),
                  )
                ],
              )
            ],
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
