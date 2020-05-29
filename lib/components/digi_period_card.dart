import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DigiPeriodCard extends StatefulWidget {
  DigiPeriodCard({Key key}) : super(key: key);

  @override
  _DigiPeriodCardState createState() => _DigiPeriodCardState();
}

class _DigiPeriodCardState extends State<DigiPeriodCard> {
  PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0, viewportFraction: 0.9);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: <Widget>[
          PageView.builder(
            controller: _pageController,
            itemCount: 3,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.only(left: 2, right: 2),
                child: Card(
                  elevation: 8,
                  color: Colors.blue[100].withOpacity(0.6),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          child: Text(
                        'Time Table',
                        style: TextStyle(fontSize: 12),
                      )),
                      Container(
                          child: Text('Period : 6   Class : X D',
                              style: TextStyle(fontSize: 18)))
                    ],
                  ),
                ),
              );
            },
          ),
          Positioned(
              left: 30,
              child: GestureDetector(
                onTap: () {
                  _pageController.previousPage(
                      duration: Duration(milliseconds: 600),
                      curve: Curves.fastLinearToSlowEaseIn);
                },
                child: Container(
                  height: 60,
                  child: Icon(
                    CupertinoIcons.left_chevron,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              )),
          Positioned(
              right: 30,
              child: GestureDetector(
                onTap: () {
                  _pageController.nextPage(
                      duration: Duration(milliseconds: 600),
                      curve: Curves.fastLinearToSlowEaseIn);
                },
                child: Container(
                  height: 60,
                  child: Icon(
                    CupertinoIcons.right_chevron,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
