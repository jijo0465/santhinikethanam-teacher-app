import 'package:flutter/material.dart';

class ProfileTextfield extends StatelessWidget {
  final String labeltext;
  final ValueChanged<String> onchanged;
  final ValueChanged<String> validator;
  final ValueChanged<String> onsaved;
  const ProfileTextfield({Key key, this.labeltext, this.onchanged, this.validator, this.onsaved}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      
      child: TextFormField(
        cursorColor: Colors.pink,
        decoration: InputDecoration(
           contentPadding: EdgeInsets.symmetric(vertical: 3,horizontal: 6),
            labelText: labeltext,
            labelStyle: TextStyle(color: Colors.black),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.pink,
              ),
              borderRadius: BorderRadius.circular(30.0),
            )),
            onChanged: onchanged,
            validator:validator,
            onSaved: onsaved,
      ),
    );
  }
}
