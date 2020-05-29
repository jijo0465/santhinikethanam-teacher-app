import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:teacher_app/components/digicampus_appbar.dart';
import 'package:teacher_app/components/homework_card.dart';
import 'package:teacher_app/components/student_list.dart';

class UpdateHomework extends StatefulWidget {
  const UpdateHomework({Key key}) : super(key: key);

  @override
  _UpdateHomeworkState createState() => _UpdateHomeworkState();
}

class _UpdateHomeworkState extends State<UpdateHomework> {
  String textHolder = 'All Students';

  bool value = true;
  int grade = 0;
  int division = 0;
  int work = 0;
  GlobalKey<AnimatedListState> _listKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 110),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(
                              color: Colors.blue,
                              style: BorderStyle.solid,
                              width: 0.80),
                        ),
                        padding: EdgeInsets.only(left: 20),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.blue,
                              ),
                              value: grade,
                              items: [
                                DropdownMenuItem(
                                  child: Text('Class '),
                                  value: 0,
                                ),
                                DropdownMenuItem(
                                    child: Text('Class I'), value: 1),
                                DropdownMenuItem(
                                    child: Text('Class II'), value: 2),
                                DropdownMenuItem(
                                    child: Text('Class III'), value: 3),
                                DropdownMenuItem(
                                    child: Text('Class IV'), value: 4),
                              ],
                              onChanged: (value) {
                                division = 0;
                                setState(() {
                                  grade = value;
                                });
                              }),
                        )),
                    Container(
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(
                              color: Colors.blue,
                              style: BorderStyle.solid,
                              width: 0.80),
                        ),
                        padding: EdgeInsets.only(left: 20),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.blue,
                              ),
                              value: division,
                              items: [
                                DropdownMenuItem(
                                  child: Text('Div '),
                                  value: 0,
                                ),
                                DropdownMenuItem(
                                  child: Text('A'),
                                  value: 1,
                                ),
                                DropdownMenuItem(
                                  child: Text('B'),
                                  value: 2,
                                ),
                                DropdownMenuItem(
                                  child: Text('C'),
                                  value: 3,
                                ),
                                DropdownMenuItem(
                                  child: Text('D'),
                                  value: 4,
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  division = value;
                                });
                              }),
                        )),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                          child: Text(
                              value ? 'Selected students' : 'All students',
                              style: TextStyle(fontSize: 16))),
                      Container(
                        child: CupertinoSwitch(
                          value: value,
                          onChanged: (val) {
                            setState(() {
                              value = val;
                            });
                          },
                          activeColor: Colors.blue,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(
                        color: Colors.blue,
                        style: BorderStyle.solid,
                        width: 0.80),
                  ),
                  padding: EdgeInsets.only(left: 20),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.blue,
                        ),
                        value: work,
                        items: [
                          DropdownMenuItem(child: Text('Homework'), value: 0),
                          DropdownMenuItem(child: Text('Assignment'), value: 1),
                        ],
                        onChanged: (value) {
                          setState(() {
                            work = value;
                          });
                        }),
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  width: 300,
                  child: TextFormField(
                      minLines: 2,
                      maxLines: 5,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(color: Colors.black)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(color: Colors.blue)))),
                ),
                SizedBox(height: 20),
                value
                    ? Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12),
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: StudentList()),
                      )
                    : Container(),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0)),
                    color: Theme.of(context).primaryColor,
                    onPressed: () {},
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
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
