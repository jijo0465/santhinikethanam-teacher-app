import 'package:flutter/material.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 70,
              ),
              Container(
                height: 100,
                width: 100,
                child: Card(
                    elevation: 1,
                    color: Colors.white,
                    child: Image.asset('assets/images/logo.jpg')),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                child: Text(
                  'Forgot Password',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 40,
                width: 300,
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "New Password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(color: Colors.blue)),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 40,
                width: 300,
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Confirm Password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(color: Colors.blue)),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                  height: 40,
                  width: 300,
                  child: RaisedButton(
                    onPressed: () {},
                    child: Text(
                      'submit',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    color: Colors.pink[200],
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0)),
                  )),
              SizedBox(height: 40),
            ],
          ),
        ));
  }
}
