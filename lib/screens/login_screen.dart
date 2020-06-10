import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:teacher_app/states/login_state.dart';
import 'package:teacher_app/states/teacher_state.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _id;
  String _password;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    TeacherState teacherState = Provider.of<TeacherState>(context, listen: true);
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: true,
        body: Center(
          child: SingleChildScrollView(
            child: IntrinsicHeight(
              child: Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 70,
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      child: Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                          elevation: 1,
                          color: Colors.white,
                          child: Image.asset('assets/images/school_logo.jpeg')),
                    ),
                    Container(
                      child: Text('Santhinikethanam Central School',style: TextStyle(color: Colors.black87,fontSize: 11),),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Text(
                        'Teacher Sign In',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      // onChanged: (value) => _id = value,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 58,
                      width: MediaQuery.of(context).size.width*0.75,
                      child: TextFormField(
                        autofocus: true,
                        validator: (code){
                          if(code==null||code=='')
                            return ' ';
                          else
                            return null;
                        },
//                        autovalidate: true,
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          _id = value;
                          formKey.currentState.validate();
                          },
                        decoration: InputDecoration(
                          errorStyle: TextStyle(fontSize: 0,),
//                          helperText: 'Enter code provided by school',
                          counterText: ' ',
                          counterStyle: TextStyle(fontSize: 0),
                          labelText: "Teacher Code",
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
                      height: 58,
                      width: MediaQuery.of(context).size.width*0.75,
                      child: TextFormField(
                        autofocus: true,
                        validator: (code){
                          if(code==null||code=='')
                            return ' ';
                          else
                            return null;
                        },
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          _password = value;
                          formKey.currentState.validate();},
                        decoration: InputDecoration(
                          errorStyle: TextStyle(fontSize: 0,),
//                          helperText: 'Enter code provided by school',
                          counterText: ' ',
                          counterStyle: TextStyle(fontSize: 0),
                          labelText: "PIN",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: const BorderSide(color: Colors.blue)),
                        ),
                      ),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width*0.75,
                        alignment: Alignment.centerRight,
                        child: FlatButton(
                          onPressed: null,
                            padding: EdgeInsets.all(0),
//                        onPressed: () {
//                          Navigator.of(context).pushNamed('/forgot_password');
//                        },
                            child: Text(
                              'Forgot pin? Contact Admin',
                              style: TextStyle(
                                  fontWeight: FontWeight.w300, color: Colors.blue,fontSize: 10),
                            ))),
                    Expanded(
                      child: Container(),
                    ),
                    Consumer<LoginState>(
                      builder: (context, value, child) {
                        return Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width*0.9,
                            child: RaisedButton(
                              onPressed: () async {
                                if(formKey.currentState.validate())
                                  await value.signIn(_id, _password,teacherState);
                              },
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, color: Colors.white),
                              ),
                              color: Theme.of(context).primaryColor,
                              elevation: 6,
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(18.0)),
                            ));
                      },
                    ),

                    SizedBox(height: 12,)

                  ],
                ),
              ),
            ),
          ),
        )
      // Center(
      //   child: Column(
      //     children: <Widget>[
      //       Container(
      //         child: Text('Login Screen'),
      //       ),
      //       Container(
      //         padding: EdgeInsets.all(12),
      //         child: TextFormField(
      //           textInputAction: TextInputAction.next,
      //           keyboardType: TextInputType.number,
      //           decoration: InputDecoration(
      //             labelText: 'Paren Id',
      //           ),
      //           onChanged: (value) => _id = value,
      //         ),
      //       ),
      //       Container(
      //         padding: EdgeInsets.all(12),
      //         child: TextFormField(
      //           textInputAction: TextInputAction.next,
      //           decoration: InputDecoration(
      //             labelText: 'Password',
      //           ),
      //           onChanged: (value) {
      //             _password = value;
      //           },
      //         ),
      //       ),

      //     ],
      //   ),
      // ),
    );
  }
}