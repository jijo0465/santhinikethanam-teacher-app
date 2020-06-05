import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:teacher_app/components/select_class.dart';
import 'package:teacher_app/components/select_division.dart';

class ConfirmClass extends StatefulWidget {
  ConfirmClass({Key key}) : super(key: key);

  @override
  _ConfirmClassState createState() => _ConfirmClassState();
}

class _ConfirmClassState extends State<ConfirmClass> {
  int grade = 0;
  int division = 0;
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))),
          elevation: 8,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            width: MediaQuery.of(context).size.width * 0.65,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 8),
                Container(
                  child: Text('Confirm Class'),
                ),
                Divider(
                  height: 2,
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(
                            color: Colors.blue,
                            style: BorderStyle.solid,
                            width: 0.80),
                      ),
                      padding: EdgeInsets.only(left: 16),
                      child: SelectClass(
                        onchanged: (value) {
                          setState(() {
                            grade = value;
                          });
                        },
                        grade: grade,
                      ),
                    ),
                    Container(
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(
                            color: Colors.blue,
                            style: BorderStyle.solid,
                            width: 0.80),
                      ),
                      padding: EdgeInsets.only(left: 16),
                      child: SelectDivision(
                        onchanged: (value) {
                          setState(() {
                            division = value;
                          });
                        },
                        division: division,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)
                  ),
                  onPressed: () async {
                    await Permission.camera.request();
                    await Permission.microphone.request();
                    await Permission.storage.request();
                    await Permission.photos.request();
                    Navigator.of(context).pushNamed('/call');
                  },
                  child: Text(
                    '  Enter  ',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(height: 10)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
