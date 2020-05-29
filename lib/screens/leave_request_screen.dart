import 'package:flutter/material.dart';
import 'package:teacher_app/components/date_picker.dart';
import 'package:teacher_app/components/digicampus_appbar.dart';

class LeaveRequest extends StatefulWidget {
  const LeaveRequest({Key key}) : super(key: key);

  @override
  _LeaveRequestState createState() => _LeaveRequestState();
}

class _LeaveRequestState extends State<LeaveRequest> {
  DateTime selectDate=DateTime.now();
  bool showTimeline = false;
  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
        body: Stack(
      children: <Widget>[
        Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 140),
              Container(
                  width: 300,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text('From'),
                          DatePicker(
                            selectedDate: selectDate,
                            daySelect: (value){
                              selectDate=value;
                            },
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text('To'),
                          DatePicker(
                            selectedDate: selectDate,
                            daySelect: (value){
                              selectDate=value;
                            },
                          ),
                        ],
                      )
                    ],
                  )),
              SizedBox(
                height: 30,
              ),
              Container(
                width: 300,
                child: TextFormField(
                    minLines: 2,
                    maxLines: 5,
                    decoration: InputDecoration(
                        hintText: 'Reason',
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(color: Colors.black)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(color: Colors.blue)))),
              ),
              SizedBox(
                height: 50,
              ),
              RaisedButton(
                onPressed: () {},
                child: Text(
                  'Request for leave',
                  style: TextStyle(color: Colors.white),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
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
            colors: [color.withOpacity(0.8), color, color.withOpacity(0.9)],
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
            colors: [color.withOpacity(0.8), color, color.withOpacity(0.9)],
          ),
              ),
              width: (MediaQuery.of(context).size.width),
              height: MediaQuery.of(context).size.height - 120 - 30 - 12,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left:14,right: 14),
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 20),
                              Text('Fromdate - Todate'),
                              Text(
                                'Status:',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Text('Approved',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500)),
                                      Container(
                                        width: 30,
                                        height: 15,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.green,
                                            border:
                                                Border.all(color: Colors.grey)),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text('pending',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500)),
                                      Container(
                                        width: 30,
                                        height: 15,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.orange,
                                            border:
                                                Border.all(color: Colors.grey)),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text('Denied',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500)),
                                      Container(
                                        width: 30,
                                        height: 15,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.red,
                                            border:
                                                Border.all(color: Colors.grey)),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        )),
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
    ));
  }
}
