import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatelessWidget {
  final ValueChanged<DateTime> daySelect;
  final DateTime selectedDate;
  const DatePicker({Key key, this.daySelect, this.selectedDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var customFormat = DateFormat('dd-MM-yyyy');

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '${customFormat.format(selectedDate)}',
            style: TextStyle(fontSize: 16),
          ),
          Container(
            width: 30,
            height: 20,
            child: GestureDetector(
              onTap: () => showPicker(context),
              child: Image.asset('assets/images/calendar.jpg'),
            ),
          ),
        ],
      ),
    );
  }

  Future<Null> showPicker(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));

    if (picked != null && picked != selectedDate) daySelect(picked);
  }
}
