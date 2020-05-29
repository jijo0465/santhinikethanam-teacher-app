import 'package:flutter/material.dart';
import 'package:teacher_app/components/digicampus_appbar.dart';
import 'package:teacher_app/components/test_paper_card.dart';

class UpdateTestPaper extends StatefulWidget {
  const UpdateTestPaper({Key key}) : super(key: key);

  @override
  _UpdateTestPaperState createState() => _UpdateTestPaperState();
}

class _UpdateTestPaperState extends State<UpdateTestPaper> {
  GlobalKey<AnimatedListState> _listKey = GlobalKey();
  //int value = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(height: 110),
              Expanded(
                  child: AnimatedList(
                key: _listKey,
                initialItemCount: 1,
                itemBuilder:
                    (BuildContext context, int index, Animation animation) {
                  return SizeTransition(
                    child: TestPaper(
                      onPressed: () {
                       if(index!=0)
                       {
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
              )),
              Padding(
                padding: const EdgeInsets.only(bottom: 12, left: 12, right: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    FloatingActionButton(
                      onPressed: () {
                        _listKey.currentState.insertItem(1,
                            duration: const Duration(milliseconds: 500));
                      },
                      child: Icon(Icons.add),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ),
            ],
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
