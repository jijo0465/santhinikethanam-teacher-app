import 'package:flutter/material.dart';

class SelectClass extends StatelessWidget {
  final ValueChanged onchanged;
  final int grade ;
  const SelectClass({Key key, this.onchanged,this.grade}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
                            child: DropdownButton(
                                value: grade,
                                items: [
                                  DropdownMenuItem(
                                    child: Text('Class '),
                                    value: 0,
                                  ),
                                  DropdownMenuItem(
                                      child: Text('Class VIII'), value: 8),
                                  DropdownMenuItem(
                                      child: Text('Class IX'), value: 9),
                                  DropdownMenuItem(
                                      child: Text('Class X'), value: 10),
                                ],
                                onChanged: onchanged),
                          );
  }
}