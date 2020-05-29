import 'package:flutter/material.dart';

class SelectStudent extends StatelessWidget {
  final int student;
  final ValueChanged onchanged;
  const SelectStudent({Key key, this.onchanged, this.student}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                      value: student,
                                      items: [
                                        DropdownMenuItem(
                                          child: Text('Student'),
                                          value: 0,
                                        ),
                                        DropdownMenuItem(
                                          child: Text(' Jon Snow'),
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
                                          child: Text('Danaerys'),
                                          value: 4,
                                        ),
                                      ],
                                      onChanged: onchanged),
                                );
  }
}