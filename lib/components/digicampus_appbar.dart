import 'package:flutter/material.dart';

class DigiCampusAppbar extends StatelessWidget {
  final VoidCallback onDrawerTapped;
  final IconData icon;
  const DigiCampusAppbar({Key key, this.onDrawerTapped, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    return Column(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).padding.top,
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [color.withOpacity(0.8), color, color.withOpacity(0.8)],
            // tileMode: TileMode.repeated,
          )),
        ),
        Container(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: GestureDetector(
                  onTap: onDrawerTapped,
                  child: Container(
                    child: Icon(icon, color: Colors.white),
                  ),
                ),
              ),
              // Text(
              //   'DigiCampus',
              //   style: TextStyle(
              //       letterSpacing: 1,
              //       color: Colors.white,
              //       fontSize: 20,
              //       fontWeight: FontWeight.w600),
              // ),
              Container(
                  height: 28,
                  width: 28,
                  child: Image.asset('assets/images/digi_campus_logo.png',
                      fit: BoxFit.fill)),
              Padding(
                padding: const EdgeInsets.only(right: 30),
                child: Container(
                    height: 30,
                    width: 30,
                    child: IconButton(
                        icon: Icon(Icons.notification_important,color: Colors.white,),
                        onPressed: (){})),
              ),

              // Icon(
              //   Icons.notification_important,
              //   color: Colors.white,
              // ),
            ],
          ),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [color.withOpacity(0.8), color, color.withOpacity(0.8)],
                // tileMode: TileMode.repeated,
              ),
              ),
          height: 50,
          width: MediaQuery.of(context).size.width,
        ),
      ],
    );
  }
}
