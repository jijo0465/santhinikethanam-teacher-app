import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LoginDatePicker extends StatefulWidget {
  const LoginDatePicker({Key key}) : super(key: key);

  @override
  _LoginDatePickerState createState() => _LoginDatePickerState();
}

class _LoginDatePickerState extends State<LoginDatePicker> {
  DateTime selectedDate = DateTime.now();

  var customFormat = DateFormat('dd-MM-yyyy');

  Future<Null> showPicker(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));

    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${customFormat.format(selectedDate)}',
              style: TextStyle(fontSize: 16),
            ),
          ),
           Container(
            width: 30,
            height: 20,
            child: GestureDetector(
              onTap: () => showPicker(context),
              //padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Image.asset('assets/images/calendar.jpg'),
            ),
          ),
        ],
      ),
    );
  }
}
