import 'package:flutter/material.dart';
import 'package:teacher_app/components/digi_rating.dart';
import 'package:teacher_app/components/select_student.dart';

class RewardCard extends StatefulWidget {
  final VoidCallback onPressed;
  const RewardCard({Key key, this.onPressed}) : super(key: key);

  @override
  _RewardCardState createState() => _RewardCardState();
}

class _RewardCardState extends State<RewardCard> {
  int student = 0;
  double rate = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
          elevation: 5,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.only(left: 50),
                      child: Text(
                        'Select Student',
                        style: TextStyle(fontSize: 18),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(
                            color: Colors.blue,
                            style: BorderStyle.solid,
                            width: 0.80),
                      ),
                      padding: EdgeInsets.only(left: 16),
                      child: SelectStudent(
                        onchanged: (value) {
                          setState(() {
                            student = value;
                          });
                        },
                        student: student,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color:  Theme.of(context).primaryColor),
                child: DigiRating(
                  rating: 0,
                  valueChanged: (value) {
                    print(value);
                    setState(() {
                      rate = value;
                    });
                  },
                ),
              ),
              SizedBox(height: 10),
              Container(
                  child: (rate == 1)
                      ? Text('Participated in',style: TextStyle(fontWeight: FontWeight.w600),)
                      : (rate == 2)
                          ? Text('Got prize in',style: TextStyle(fontWeight: FontWeight.w600))
                          : (rate == 3)
                              ? Text('Got First Prize in',style: TextStyle(fontWeight: FontWeight.w600))
                              : Container()),
              SizedBox(height: 10),
              Container(
                width: 300,
                child: TextFormField(
                  minLines: 1,
                  maxLines: 3,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Colors.grey)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Colors.grey)),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0)),
                    color: Theme.of(context).primaryColor,
                    onPressed: () {},
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0)),
                    color: Theme.of(context).primaryColor,
                    onPressed: widget.onPressed,
                    child: Text(
                      'Remove',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              SizedBox(height:10)
            ],
          )),
    );
  }
}
