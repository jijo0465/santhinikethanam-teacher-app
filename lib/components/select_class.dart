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
                                      child: Text('Class I'), value: 1),
                                  DropdownMenuItem(
                                      child: Text('Class II'), value: 2),
                                  DropdownMenuItem(
                                      child: Text('Class III'), value: 3),
                                  DropdownMenuItem(
                                      child: Text('Class IV'), value: 4),
                                ],
                                onChanged: onchanged),
                          );
  }
}