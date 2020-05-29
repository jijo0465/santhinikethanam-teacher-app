import 'package:flutter/material.dart';
import 'package:teacher_app/components/digicampus_appbar.dart';
import 'package:teacher_app/components/login_date_picker.dart';
import 'package:teacher_app/components/profile_textfield.dart';
import 'package:teacher_app/components/select_class.dart';
import 'package:teacher_app/components/select_division.dart';
import 'package:teacher_app/components/select_student.dart';

class UpdateStudentProfile extends StatefulWidget {
  const UpdateStudentProfile({Key key}) : super(key: key);

  @override
  _UpdateStudentProfileState createState() => _UpdateStudentProfileState();
}

class _UpdateStudentProfileState extends State<UpdateStudentProfile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  int grade = 0;
  int division = 0;
  int student = 0;
  String _address;
  String _gname;
  String _fname;
  String _lname;
  String _pname;
  String _poccup;
  String _contact;
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
                Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 50),
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
                        child: SelectClass(
                          onchanged: (value) {
                            division = 0;
                            student = 0;
                            setState(() {
                              grade = value;
                            });
                          },
                          grade: grade,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10),
                grade == 0
                    ? Container()
                    : Row(
                        children: <Widget>[
                          Container(
                              padding: EdgeInsets.only(left: 50),
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
                              child: SelectDivision(
                                onchanged: (value) {
                                  student = 0;
                                  setState(() {
                                    division = value;
                                  });
                                },
                                division: division,
                              ),
                            ),
                          )
                        ],
                      ),
                SizedBox(height: 10),
                division == 0
                    ? Container()
                    : Row(
                        children: <Widget>[
                          Container(
                              padding: EdgeInsets.only(left: 50),
                              child: Text(
                                'Select Student',
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
                              padding: EdgeInsets.only(left: 18),
                              child: SelectStudent(
                                onchanged: (value) {
                                  setState(() {
                                    student = value;
                                  });
                                },
                                student: student,
                              ),
                            ),
                          )
                        ],
                      ),
                SizedBox(height: 10),
                student == 0
                    ? Container()
                    : Container(
                        child: Column(
                          children: <Widget>[
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(10.0)),
                              elevation: 4,
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: <Widget>[
                                    Stack(
                                      children: <Widget>[
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
                                        Container(
                                            padding: EdgeInsets.fromLTRB(
                                                40, 45, 0, 0),
                                            child: IconButton(
                                                color: Colors.blue[100],
                                                icon: Icon(Icons.camera_alt),
                                                onPressed: () {}))
                                      ],
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
                                    Form(
                                        key: _formKey,
                                        autovalidate: _autoValidate,
                                        child: Column(
                                          children: <Widget>[
                                            ProfileTextfield(
                                              labeltext: 'First Name',
                                              onchanged: (value) {
                                                _fname = value;
                                                print(value);
                                              },
                                              validator: validateName,
                                              onsaved: (String val) {
                                                _fname = val;
                                              },
                                            ),
                                            SizedBox(height: 10),
                                            ProfileTextfield(
                                              labeltext: 'Last Name',
                                              onchanged: (value) {
                                                _lname = value;
                                                print(value);
                                              },
                                            ),
                                            SizedBox(height: 10),
                                            Container(
                                              height: 45,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  border: Border.all(
                                                      color: Colors.grey)),
                                              child: Row(
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: SelectClass(
                                                      onchanged: (value) {
                                                        setState(() {
                                                          grade = value;
                                                        });
                                                      },
                                                      grade: grade,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 50),
                                                    child: SelectDivision(
                                                      onchanged: (value) {
                                                        setState(() {
                                                          division = value;
                                                        });
                                                      },
                                                      division: division,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  border: Border.all(
                                                      color: Colors.grey)),
                                              child: LoginDatePicker(),
                                            ),
                                            SizedBox(height: 10),
                                            ProfileTextfield(
                                              labeltext: 'Parent Name',
                                              onchanged: (value) {
                                                _pname = value;
                                                print(value);
                                              },
                                              validator: validateName,
                                              onsaved: (String val) {
                                                _pname = val;
                                              },
                                            ),
                                            SizedBox(height: 10),
                                            ProfileTextfield(
                                              labeltext: 'Parent Occupation',
                                              onchanged: (value) {
                                                _poccup = value;
                                                print(value);
                                              },
                                            ),
                                            SizedBox(height: 10),
                                            ProfileTextfield(
                                              labeltext: 'Contact',
                                              onchanged: (value) {
                                                _contact = value;
                                                print(value);
                                              },
                                              validator: validateContact,
                                              onsaved: (String val) {
                                                _contact = val;
                                              },
                                            ),
                                            SizedBox(height: 10),
                                            ProfileTextfield(
                                              labeltext: 'Guardian Name',
                                              onchanged: (value) {
                                                _gname = value;
                                                print(value);
                                              },
                                              validator: validateName,
                                              onsaved: (String val) {
                                                _gname = val;
                                              },
                                            ),
                                            SizedBox(height: 10),
                                            Container(
                                              height: 80,
                                              child: TextFormField(
                                                minLines: 2,
                                                maxLines: 2,
                                                cursorColor: Colors.pink,
                                                decoration: InputDecoration(
                                                    labelText: "Address",
                                                    labelStyle: TextStyle(
                                                        color: Colors.black),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30.0),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                        color: Colors.pink,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30.0),
                                                    )),
                                                onChanged: (value) {
                                                  _address = value;
                                                  print(value);
                                                },
                                              ),
                                            ),
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.edit),
                                ),
                                RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(10.0)),
                                    color: Theme.of(context).primaryColor,
                                    onPressed: _validateInputs,
                                    child: Text(
                                      'save',
                                      style: TextStyle(color: Colors.white),
                                    ))
                              ],
                            ),
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

  String validateName(String value) {
    if (value.length < 3)
      return 'Name must be more than 2 charater';
    else
      return null;
  }

  void _validateInputs() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }
  String validateContact(String value){
    if (value.length != 10)
      return 'Mobile Number must be of 10 digit';
    else
      return null;
  }
}
