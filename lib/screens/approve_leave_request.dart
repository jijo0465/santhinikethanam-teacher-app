import 'package:flutter/material.dart';
import 'package:teacher_app/components/digicampus_appbar.dart';

class ApproveLeaveRequest extends StatefulWidget {
  const ApproveLeaveRequest({Key key}) : super(key: key);

  @override
  _ApproveLeaveRequestState createState() => _ApproveLeaveRequestState();
}

class _ApproveLeaveRequestState extends State<ApproveLeaveRequest> {
  bool showTimeline = false;
  bool _value = true;
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
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    elevation: 4,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 10),
                        Text(
                          'Leave Approval',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 12),
                              child: Text('Name'),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 12, left: 12),
                              child: Text(':'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 14),
                              child: Text('Abhay'),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text('Class'),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 12, right: 12),
                              child: Text(':'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 22),
                              child: Text('VII A'),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text('From Date'),
                            Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: Text(':'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Text('12-07-2020'),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text('To Date'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 18),
                              child: Text(':'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Text('12-07-2020'),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 6),
                              child: Text('Reason'),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 12, right: 12),
                              child: Text(':'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: Text('data......'),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(10.0)),
                              color: Theme.of(context).primaryColor,
                              onPressed: () {},
                              child: Text(
                                'Approve',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(10.0)),
                              color: Theme.of(context).primaryColor,
                              onPressed: () {},
                              child: Text(
                                'Contact',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )),
            )
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
                    color.withOpacity(0.9)
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
                      height: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        elevation: 2,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12, right: 12),
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Container(
                                          child: Text(
                                        '11/06/2020',
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.blue),
                                      )),
                                      Container(
                                          child: Text(
                                        'VII A',
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.blue),
                                      )),
                                      Container(
                                          child: Text(
                                        'Abhay',
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.blue),
                                      )),
                                    ],
                                  ),
                                ),
                                Divider(
                                  color: Colors.grey[500],
                                  thickness: 1.5,
                                ),
                              ],
                            ),
                          ),
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
    ));
  }
}
