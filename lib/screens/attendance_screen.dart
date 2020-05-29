import 'package:flutter/material.dart';
import 'package:teacher_app/components/attendance_table.dart';
import 'package:teacher_app/components/digi_attendance_card.dart';
import 'package:teacher_app/components/digicampus_appbar.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({Key key}) : super(key: key);

  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 120,
                ),
                AttendanceCard(),
                SizedBox(height: 20),
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
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 12, left: 120, right: 100),
                  child: Row(
                    children: <Widget>[
                      RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0)),
                          color: Theme.of(context).primaryColor,
                          onPressed: () {},
                          child: Text(
                            'Update',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          )),
                      Container(
                          child: IconButton(
                              icon: Icon(
                                Icons.history,
                                color: Colors.black,
                              ),
                              onPressed: (){
                                Navigator.of(context).pushNamed('/attendance_history');
                              }))
                    ],
                  ),
                ),
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
