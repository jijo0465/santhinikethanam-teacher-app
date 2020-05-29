import 'package:flutter/material.dart';

class AttendanceCard extends StatelessWidget {
  const AttendanceCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle =
        TextStyle(fontSize: 18, fontWeight: FontWeight.w600);
    return Container(
        width: MediaQuery.of(context).size.width*0.8,
        
        child: Stack(
          children: <Widget>[
            Container(
              child: Card(
                  margin: EdgeInsets.all(12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: Colors.grey)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(left: 30),
                                child: Text(
                                  'Total Strength',
                                  style: textStyle,
                                ),
                              ),
                              Container(
                                  padding: EdgeInsets.only(right: 40),
                                  child: Text(': 45', style: textStyle))
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(left: 30),
                                child: Text('Total Present', style: textStyle),
                              ),
                              Container(
                                  padding: EdgeInsets.only(right: 40),
                                  child: Text(': 40', style: textStyle))
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(left: 30),
                                child: Text('Total Absent', style: textStyle),
                              ),
                              Container(
                                  padding: EdgeInsets.only(right: 40),
                                  child: Text(': 05', style: textStyle))
                            ],
                          ),
                        ],
                      ),
                    ),
                  )),
            ),
            Align(alignment: Alignment.topCenter,
                          child: Container(
                            
                color: Colors.white,
                child:Text('TODAY\'S STRENGTH',style: TextStyle(fontWeight: FontWeight.w500),)),
            )
          ],
        ));
  }
}
