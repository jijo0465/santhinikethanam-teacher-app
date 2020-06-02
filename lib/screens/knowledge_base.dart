import 'package:flutter/material.dart';
import 'package:teacher_app/components/digi_teach.dart';
import 'package:teacher_app/models/grade.dart';
import 'package:video_player/video_player.dart';

class KnowledgeBase extends StatefulWidget {
  const KnowledgeBase({Key key}) : super(key: key);

  @override
  _KnowledgeBaseState createState() => _KnowledgeBaseState();
}

class _KnowledgeBaseState extends State<KnowledgeBase> {
  bool val = false;
  // List<Widget> discussionListWidget = [];
  // int id = 4001;
  // int widgetIndex;
  // Grade grade = Grade.empty();
  // VideoPlayerController _playerController;
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   widgetIndex = 0;
  //   grade.setId(id);
  //   _playerController =
  //       VideoPlayerController.asset('assets/videos/smartschool.mp4')
  //         ..initialize().then((_) {
  //           // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
  //           setState(() {
  //             _playerController.play();
  //           });
  //         });

  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   discussionListWidget.clear();
  //   _playerController.dispose();

  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
//      child: Column(
//        children: <Widget>[
//          Container(
//            alignment: Alignment.center,
//            child: Text('Knowledge Database'),
//          ),
//          SizedBox(height: 20,)
//        ],
//      )
//    );
//  }
//}
      child: Stack(
        children: <Widget>[
          //Container(color: Theme.of(context).primaryColor.withOpacity(0.15)),
          Column(
            children: <Widget>[
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.dehaze,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        val = !val;
                      });
                    },
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 35,
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "search",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(color: Colors.blue)),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 80,
                        width: MediaQuery.of(context).size.width * 0.94,
                        decoration: BoxDecoration(
                            border: Border.all(
                          style: BorderStyle.solid,
                          color: Colors.black,
                        )),
                        child: Row(
                          children: <Widget>[
                            Container(
                              height: 80,
                              width: 120,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/tutorial2.jpg'),
                                      fit: BoxFit.fill)),
                            ),
                            SizedBox(width: 10),
                            Column(
                              children: <Widget>[
                                Text('Whole Numbers',
                                    style: TextStyle(fontSize: 16)),
                                Row(
                                  children: <Widget>[
                                    Container(
                                        child: Icon(
                                      Icons.brightness_1,
                                      size: 10,
                                      color: Colors.grey,
                                    )),
                                    Text('VII', style: TextStyle(fontSize: 10)),
                                    Container(
                                        child: Icon(
                                      Icons.brightness_1,
                                      size: 10,
                                      color: Colors.grey,
                                    )),
                                    Text('Maths',
                                        style: TextStyle(fontSize: 10)),
                                    Container(
                                        child: Icon(
                                      Icons.timer,
                                      size: 10,
                                      color: Colors.grey,
                                    )),
                                    Text('8 min',
                                        style: TextStyle(fontSize: 10)),
                                  ],
                                ),
                                Text('Description of the topic')
                              ],
                            )
                          ],
                        ),
                        // child:  _playerController.value.initialized? AspectRatio(
                        //           aspectRatio: _playerController.value.aspectRatio,
                        //           child: VideoPlayer(_playerController),
                        //         ):Container(),
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: 80,
                        width: MediaQuery.of(context).size.width * 0.94,
                        decoration: BoxDecoration(
                            border: Border.all(
                          style: BorderStyle.solid,
                          color: Colors.black,
                        )),
                        child: Row(
                          children: <Widget>[
                            Container(
                              height: 80,
                              width: 120,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/tutorial2.jpg'),
                                      fit: BoxFit.fill)),
                            ),
                            SizedBox(width: 10),
                            Column(
                              children: <Widget>[
                                Text('Integers',
                                    style: TextStyle(fontSize: 16)),
                                Row(
                                  children: <Widget>[
                                    Container(
                                        child: Icon(
                                      Icons.brightness_1,
                                      size: 10,
                                      color: Colors.grey,
                                    )),
                                    Text('V', style: TextStyle(fontSize: 10)),
                                    Container(
                                        child: Icon(
                                      Icons.brightness_1,
                                      size: 10,
                                      color: Colors.grey,
                                    )),
                                    Text('Maths',
                                        style: TextStyle(fontSize: 10)),
                                    Container(
                                        child: Icon(
                                      Icons.timer,
                                      size: 10,
                                      color: Colors.grey,
                                    )),
                                    Text('12 min',
                                        style: TextStyle(fontSize: 10)),
                                  ],
                                ),
                                Text('Description of the topic')
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: 80,
                        width: MediaQuery.of(context).size.width * 0.94,
                        decoration: BoxDecoration(
                            border: Border.all(
                          style: BorderStyle.solid,
                          color: Colors.black,
                        )),
                        child: Row(
                          children: <Widget>[
                            Container(
                              height: 80,
                              width: 120,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/tutorial.jpg'),
                                      fit: BoxFit.fill)),
                            ),
                            SizedBox(width: 10),
                            Column(
                              children: <Widget>[
                                Text('English Grammer',
                                    style: TextStyle(fontSize: 16)),
                                Row(
                                  children: <Widget>[
                                    Container(
                                        child: Icon(
                                      Icons.brightness_1,
                                      size: 10,
                                      color: Colors.grey,
                                    )),
                                    Text('V', style: TextStyle(fontSize: 10)),
                                    Container(
                                        child: Icon(
                                      Icons.brightness_1,
                                      size: 10,
                                      color: Colors.grey,
                                    )),
                                    Text('English',
                                        style: TextStyle(fontSize: 10)),
                                    Container(
                                        child: Icon(
                                      Icons.timer,
                                      size: 10,
                                      color: Colors.grey,
                                    )),
                                    Text('10 min',
                                        style: TextStyle(fontSize: 10)),
                                  ],
                                ),
                                Text('Description of the topic')
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: 80,
                        width: MediaQuery.of(context).size.width * 0.94,
                        decoration: BoxDecoration(
                            border: Border.all(
                          style: BorderStyle.solid,
                          color: Colors.black,
                        )),
                        child: Row(
                          children: <Widget>[
                            Container(
                              height: 80,
                              width: 120,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/tutorial3.jpg'),
                                      fit: BoxFit.fill)),
                            ),
                            SizedBox(width: 10),
                            Column(
                              children: <Widget>[
                                Text('Nutrition in plants',
                                    style: TextStyle(fontSize: 16)),
                                Row(
                                  children: <Widget>[
                                    Container(
                                        child: Icon(
                                      Icons.brightness_1,
                                      size: 10,
                                      color: Colors.grey,
                                    )),
                                    Text('VII', style: TextStyle(fontSize: 10)),
                                    Container(
                                        child: Icon(
                                      Icons.brightness_1,
                                      size: 10,
                                      color: Colors.grey,
                                    )),
                                    Text('Science',
                                        style: TextStyle(fontSize: 10)),
                                    Container(
                                        child: Icon(
                                      Icons.timer,
                                      size: 10,
                                      color: Colors.grey,
                                    )),
                                    Text('12 min',
                                        style: TextStyle(fontSize: 10)),
                                  ],
                                ),
                                Text('Description of the topic')
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: 80,
                        width: MediaQuery.of(context).size.width * 0.94,
                        decoration: BoxDecoration(
                            border: Border.all(
                          style: BorderStyle.solid,
                          color: Colors.black,
                        )),
                        child: Row(
                          children: <Widget>[
                            Container(
                              height: 80,
                              width: 120,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/tutorial3.jpg'),
                                      fit: BoxFit.fill)),
                            ),
                            SizedBox(width: 10),
                            Column(
                              children: <Widget>[
                                Text('Nutrition in plants',
                                    style: TextStyle(fontSize: 16)),
                                Row(
                                  children: <Widget>[
                                    Container(
                                        child: Icon(
                                      Icons.brightness_1,
                                      size: 10,
                                      color: Colors.grey,
                                    )),
                                    Text('VII', style: TextStyle(fontSize: 10)),
                                    Container(
                                        child: Icon(
                                      Icons.brightness_1,
                                      size: 10,
                                      color: Colors.grey,
                                    )),
                                    Text('Science',
                                        style: TextStyle(fontSize: 10)),
                                    Container(
                                        child: Icon(
                                      Icons.timer,
                                      size: 10,
                                      color: Colors.grey,
                                    )),
                                    Text('12 min',
                                        style: TextStyle(fontSize: 10)),
                                  ],
                                ),
                                Text('Description of the topic')
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          val == true ? Positioned(bottom: 0, child: DigiTeach()) : Container()
          // Positioned(bottom: 0,
          //    child: DigiTeach())
        ],
      ),
    );
  }
}
