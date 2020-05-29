import 'package:flutter/material.dart';
import 'package:teacher_app/components/digicampus_appbar.dart';
import 'package:teacher_app/components/rewards_card.dart';
import 'package:teacher_app/components/select_class.dart';
import 'package:teacher_app/components/select_division.dart';
//import 'package:teacher_app/components/select_student.dart';

class RewardScreen extends StatefulWidget {
  const RewardScreen({Key key}) : super(key: key);

  @override
  _RewardScreenState createState() => _RewardScreenState();
}

class _RewardScreenState extends State<RewardScreen> {
  int grade = 0;
  int division = 0;
  int listIndex = 0;
  GlobalKey<AnimatedListState> _listKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(children: <Widget>[
              SizedBox(height: 120),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 6),
                        child: Text(
                          'Select',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18),
                        child: Container(
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            border: Border.all(
                                color: Colors.blue,
                                style: BorderStyle.solid,
                                width: 0.80),
                          ),
                          padding: EdgeInsets.only(left: 12),
                          child: SelectClass(
                            onchanged: (value) {
                              setState(() {
                                grade = value;
                              });
                            },
                            grade: grade,
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.only(left: 12),
                          child: Text(
                            'Select',
                            style: TextStyle(fontSize: 18),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(left: 18),
                        child: Container(
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            border: Border.all(
                                color: Colors.blue,
                                style: BorderStyle.solid,
                                width: 0.80),
                          ),
                          padding: EdgeInsets.only(left: 20),
                          child: SelectDivision(
                            onchanged: (value) {
                              setState(() {
                                division = value;
                              });
                            },
                            division: division,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              grade == 0 || division == 0
                  ? Container()
                  : Column(
                      children: <Widget>[
                        AnimatedList(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          key: _listKey,
                          initialItemCount: 1,
                          itemBuilder: (BuildContext context, int index,
                              Animation animation) {
                            return SizeTransition(
                              child: RewardCard(
                                onPressed: () {
                                  listIndex--;
                                  if (index != 0) {
                                    _listKey.currentState.removeItem(index,
                                        (context, animation) {
                                      return Container();
                                    });
                                  }
                                },
                              ),
                              sizeFactor: animation,
                              axis: Axis.vertical,
                            );
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(right: 8),
                              child: FlatButton(
                                child: Text(
                                  'Add student',
                                  style: TextStyle(color: Colors.white),
                                ),
                                color: Theme.of(context).primaryColor,
                                onPressed: () {
                                  _listKey.currentState.insertItem(listIndex,
                                      duration: const Duration(milliseconds: 500));
                                  listIndex = listIndex + 1;
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
            ]),
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
