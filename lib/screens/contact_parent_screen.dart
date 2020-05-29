import 'package:flutter/material.dart';
import 'package:teacher_app/components/digicampus_appbar.dart';

class ContactParentScreen extends StatefulWidget {
  const ContactParentScreen({Key key}) : super(key: key);

  @override
  _ContactParentScreenState createState() => _ContactParentScreenState();
}

class _ContactParentScreenState extends State<ContactParentScreen> {
  int grade = 0;
  int division = 0;
  int student = 0;
  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle =
        TextStyle(fontSize: 16, fontWeight: FontWeight.w400);
    return Scaffold(
        body: Stack(
      children: <Widget>[
        SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 120,
                ),
                Container(
                  padding: EdgeInsets.only(left: 50),
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 12),
                        child: Text(
                          'Select Class',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 32),
                        child: Container(
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
                                    student = 0;
                                    setState(() {
                                      grade = value;
                                    });
                                    print(value);
                                  }),
                            )),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10),
                grade == 0
                    ? Container()
                    : Container(
                        padding: EdgeInsets.only(left: 50),
                        child: Row(
                          children: <Widget>[
                            Container(
                                padding: EdgeInsets.only(left: 12),
                                child: Text(
                                  'Select Division',
                                  style: TextStyle(fontSize: 18),
                                )),
                            Padding(
                              padding: const EdgeInsets.only(left: 12),
                              child: Container(
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
                                          student = 0;
                                          setState(() {
                                            division = value;
                                          });
                                        }),
                                  )),
                            )
                          ],
                        ),
                      ),
                SizedBox(height: 10),
                division == 0
                    ? Container()
                    : Container(
                      padding: EdgeInsets.only(left: 50),
                      child: Row(
                        children: <Widget>[
                          Container(
                              padding: EdgeInsets.only(left: 12),
                              child: Text(
                                'Select Student',
                                style: TextStyle(fontSize: 18),
                              )),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Container(
                                height: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  border: Border.all(
                                      color: Colors.blue,
                                      style: BorderStyle.solid,
                                      width: 0.80),
                                ),
                                padding: EdgeInsets.only(left: 18),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                      icon: Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.blue,
                                      ),
                                      value: student,
                                      items: [
                                        DropdownMenuItem(
                                          child: Text('Student'),
                                          value: 0,
                                        ),
                                        DropdownMenuItem(
                                          child: Text('Jon Snow'),
                                          value: 1,
                                        ),
                                        DropdownMenuItem(
                                          child: Text('Arya Stark'),
                                          value: 2,
                                        ),
                                        DropdownMenuItem(
                                          child: Text('Jaimie'),
                                          value: 3,
                                        ),
                                        DropdownMenuItem(
                                          child: Text('Daenarys'),
                                          value: 4,
                                        ),
                                      ],
                                      onChanged: (value) {
                                        setState(() {
                                          student = value;
                                        });
                                      }),
                                )),
                          )
                        ],
                      ),
                    ),
                SizedBox(height: 30),
                student == 0
                    ? Container()
                    : Container(
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        color: Colors.white,
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 10),
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      alignment: Alignment.center,
                                      fit: BoxFit.fill,
                                      image: AssetImage(
                                          'assets/images/child.jpg'))),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Text(
                                'ID No: 123456',
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    'Parent name',
                                    style: textStyle,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 20),
                                  child:
                                      Text(':Ned Stark', style: textStyle),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  child: Text('Address', style: textStyle),
                                ),
                                Column(
                                  children: <Widget>[
                                    Container(
                                        padding: EdgeInsets.only(left: 30),
                                        child: Text(':<line1>',
                                            style: textStyle)),
                                    Container(
                                        padding: EdgeInsets.only(left: 30),
                                        child: Text(':<line2>',
                                            style: textStyle)),
                                    Container(
                                      padding: EdgeInsets.only(left: 30),
                                      child: Text(':<line3>',
                                          style: textStyle),
                                    )
                                  ],
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  child:
                                      Text('Contact No.', style: textStyle),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 24),
                                  child:
                                      Text(':<Number>', style: textStyle),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(10.0)),
                                  onPressed: () {},
                                  child: Text(
                                    'Call',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  color: Theme.of(context).primaryColor,
                                ),
                                RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(10.0)),
                                  onPressed: () {},
                                  child: Text(
                                    'Message',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  color: Theme.of(context).primaryColor,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
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
