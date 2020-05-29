import 'package:flutter/material.dart';

class DigiMenuCard extends StatelessWidget {
  const DigiMenuCard(
      {Key key,
      this.menuIcon,
      this.title,
      this.subtitle,
      this.value,
      this.onPressed, this.imagePath, this.height, this.width})
      : super(key: key);
   final double height; 
   final double width;  
  final IconData menuIcon;
  final String title, subtitle, value;
  final VoidCallback onPressed;
  final String imagePath;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child:Container(
        height: height,
        width: width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.circular(8.0),
                image: DecorationImage(
                    image: AssetImage(
                      imagePath,
                    ),
                    fit: BoxFit.fill),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(0.0, 0.0), //(x,y)
                    blurRadius: 0.0,
                  ),
                ],
              ),
            ),
    );
  }
}
