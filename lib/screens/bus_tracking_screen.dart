import 'package:flutter/material.dart';
import 'package:teacher_app/components/digicampus_appbar.dart';

class BusTrackingScreen extends StatelessWidget {
  const BusTrackingScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
          color: Theme.of(context).primaryColor,
          height: MediaQuery.of(context).padding.top,
        ),
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black38,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.only(bottom:12),
              child: RaisedButton(
                
                onPressed: () {},
                child: Text('Contact driver'),
              ),
            ),
          ),
           DigiCampusAppbar(
                icon: Icons.close,
                onDrawerTapped: () {
                  Navigator.of(context).pop();
                },
              ),
        ],
      ),
    );
  }
}
