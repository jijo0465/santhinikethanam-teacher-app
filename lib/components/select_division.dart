import 'package:flutter/material.dart';

class SelectDivision extends StatelessWidget {
  final int division;
  final ValueChanged onchanged;

  const SelectDivision({Key key, this.onchanged, this.division}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton(
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
          onChanged: onchanged),
    );
  }
}
