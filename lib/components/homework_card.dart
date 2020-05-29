import 'package:flutter/material.dart';
import 'package:teacher_app/components/date_picker.dart';

class Homework extends StatefulWidget {
  final VoidCallback onTap;
  const Homework({Key key, this.onTap}) : super(key: key);

  @override
  _HomeworkState createState() => _HomeworkState();
}

class _HomeworkState extends State<Homework> {
  int grade = 0;
  int division = 0;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          width: 350,
          height: 170,
          child: Card(
              color: Colors.deepOrange[200],
              elevation: 5,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      DatePicker(),
                      IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: widget.onTap)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                          height: 30,
                          // decoration: BoxDecoration(
                          //   borderRadius: BorderRadius.circular(15.0),
                          //   border: Border.all(

                          //       style: BorderStyle.solid,
                          //       width: 0.80),
                          // ),
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
                                    child: Text('Select Class '),
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
                          // decoration: BoxDecoration(
                          //   borderRadius: BorderRadius.circular(15.0),
                          //   border: Border.all(
                          //       color: Colors.white,
                          //       style: BorderStyle.solid,
                          //       width: 0.80),
                          // ),
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
                  SizedBox(height: 10),
                  Container(
                    width: 300,
                    child: TextFormField(
                      minLines: 1,
                      maxLines: 3,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(color: Colors.grey)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(color: Colors.grey)),
                      ),
                    ),
                  )
                ],
              ))),
    );
  }
}
