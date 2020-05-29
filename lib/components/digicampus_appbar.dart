import 'package:flutter/material.dart';

class DigiCampusAppbar extends StatelessWidget {
  final VoidCallback onDrawerTapped;
  final IconData icon;
  const DigiCampusAppbar({Key key, this.onDrawerTapped, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    return Container(
      alignment: Alignment.bottomCenter,
      padding: EdgeInsets.only(bottom: 20),
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
          Text(
            'DIGICAMPUS',
            style: TextStyle(
                letterSpacing: 1,
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w400),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: Icon(
              Icons.notification_important,
              color: Colors.white,
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [color.withOpacity(0.8), color, color.withOpacity(0.8)],
          ),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30))),
      height: 110 - MediaQuery.of(context).padding.top,
      width: MediaQuery.of(context).size.width,
    );
  }
}
