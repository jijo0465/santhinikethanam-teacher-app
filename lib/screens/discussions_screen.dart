import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:teacher_app/components/digicampus_appbar.dart';
import 'package:teacher_app/models/grade.dart';
import 'package:teacher_app/models/student.dart';
import 'package:teacher_app/models/teacher.dart';
import 'package:teacher_app/states/teacher_state.dart';
import 'package:video_player/video_player.dart';

enum FileType {
  ANY,
  IMAGE,
  VIDEO,
  CAMERA,
  CUSTOM,
}

class FilePicker {
  static const MethodChannel _channel = const MethodChannel('file_picker');
  static const String _tag = 'FilePicker';

  static Future<String> _getPath(String type) async {
    try {
      return await _channel.invokeMethod(type);
    } on PlatformException catch (e) {
      print("[$_tag] Platform exception: " + e.toString());
    } catch (e) {
      print(
          "[$_tag] Unsupported operation. This probably have happened because [${type.split('_').last}] is an unsupported file type. You may want to try FileType.ALL instead.");
    }
    return null;
  }

  static Future<String> _getImage(ImageSource type) async {
    try {
      var image = await ImagePicker.pickImage(source: type);
      return image?.path;
    } on PlatformException catch (e) {
      print("[$_tag] Platform exception: " + e.toString());
    }
    return null;
  }

  static Future<Map<String, dynamic>> getFilePath(
      {FileType type = FileType.ANY, String fileExtension}) async {
    switch (type) {
      case FileType.IMAGE:
        final result = await _getImage(ImageSource.gallery);
        return <String, String>{'path': result};
      case FileType.VIDEO:
        final result = await _channel.invokeMethod('VIDEO');
        return Map<String, dynamic>.from(result);
      case FileType.ANY:
        final result = await _getPath('ANY');
        return <String, String>{'path': result};
      case FileType.CUSTOM:
        final result = await _getPath('__CUSTOM_' + (fileExtension ?? ''));
        return <String, String>{'path': result};
      default:
        final result = await _getPath('ANY');
        return <String, String>{'path': result};
    }
  }
}

class DiscussionsScreen extends StatefulWidget {
  // final Grade grade = Grade();
  // final Student student;

  const DiscussionsScreen({Key key}) : super(key: key);

  @override
  _DiscussionsScreenState createState() => _DiscussionsScreenState();
}

class _DiscussionsScreenState extends State<DiscussionsScreen> {
  // final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  // var _key;
  // ListModel<int> _list;
  final TextEditingController _textFieldController =
      new TextEditingController();
  Teacher _teacher;
  List<Widget> discussionListWidget = [];
  List<DocumentSnapshot> _items;
  List<Map<String, dynamic>> commentData = [];
  DocumentSnapshot addItem;
  Grade grade = Grade.empty();
  int id = 4001;
  int widgetIndex;
  Firestore firestore = Firestore.instance;
  VideoPlayerController _playerController;
  Color color = Colors.grey;
  File imageURI;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      imageURI = image;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    widgetIndex = 0;
    grade.setId(id);
    _playerController =
        VideoPlayerController.asset('assets/videos/smartschool.mp4')
          ..initialize().then((_) {
            // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
            setState(() {
              _playerController.play();
            });
          });

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    discussionListWidget.clear();
    _playerController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TeacherState state = Provider.of<TeacherState>(context, listen: true);
    _teacher = state.teacher;
    return Scaffold(
        body: Container(
      child: Column(children: <Widget>[
        DigiCampusAppbar(
          icon: Icons.close,
          onDrawerTapped: () => Navigator.of(context).pop(),
        ),
        SingleChildScrollView(
          child: Container(
            height: 250,
            width: double.infinity,
            child: Stack(
              children: <Widget>[
                Center(
                  child: _playerController.value.initialized
                      ? AspectRatio(
                          aspectRatio: _playerController.value.aspectRatio,
                          child: VideoPlayer(_playerController),
                        )
                      : Container(),
                ),
                Center(
                  child: FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        _playerController.value.isPlaying
                            ? _playerController.pause()
                            : _playerController.play();
                      });
                    },
                    child: Icon(
                      _playerController.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(height: 12),
        Text(
          'Discussions',
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        SizedBox(
          height: 12,
        ),
        Row(
         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              height: 40,
              width: MediaQuery.of(context).size.width - 100,
              // decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: TextField(
                onChanged: (text) {
                  if (text == '') {
                    setState(() {
                      color = Colors.grey;
                    });
                  } else {
                    setState(() {
                      color = Colors.deepOrange[300];
                    });
                  }
                },
                controller: _textFieldController,
                // textAlignVertical: TextAlignVertical.center,
                textAlign: TextAlign.start,
                cursorColor: Colors.blue,
                decoration: InputDecoration(
                  hintText: 'add to discussions...',
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      getImage();
                      // _addToDiscussions(_textFieldController.text);
                      // _textFieldController.clear();
                    },
                    icon: Icon(Icons.camera_alt),
                    color: Colors.blue,
                  ),
                ),

                // autofocus: true,
                // onSubmitted: (text) {
                //   // print(text);
                //   _addToDiscussions(text);
                //   _textFieldController.clear();
                //   // text = '';
                // },
              ),
            ),
            IconButton(icon: Icon(Icons.book), onPressed: (){
              FilePicker();
            }),
            Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.grey[300]),
                child: GestureDetector(
                  child: Icon(Icons.send, color: color),
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    _addToDiscussions(_textFieldController.text);
                    _textFieldController.clear();
                    setState(() {
                      color = Colors.grey;
                    });
                  },
                ))
          ],
        ),
        SizedBox(height: 12),
        // StreamBuilder<QuerySnapshot>(
        //     // key: _key,
        //     stream: firestore.collection('classroom_${grade.id}').snapshots(),
        //     builder:
        //         (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        //       if (!snapshot.hasData)
        //         return Center(
        //           child: CircularProgressIndicator(
        //             valueColor: AlwaysStoppedAnimation<Color>(
        //                 Theme.of(context).primaryColor),
        //           ),
        //         );
        //       else {
        //         _items = snapshot.data.documents;
        //         listItem(_items);
        //         // print('item: ${_items[0]}');
        //         // setState(() {
        //         // AnimatedList.of(context).insertItem(0);
        //         // Future.delayed(Duration(milliseconds: 200))
        //         //     .then((value) => _listKey.currentState.insertItem(0));

        //         // });
        //         // return listItem(_items[0]);'
        //         // commentData.addAll(_items[0]['']['']);
        //         return (_items.isNotEmpty)
        //             ? Expanded(
        //                 child: SingleChildScrollView(
        //                     child: Column(
        //                         children:
        //                             discussionListWidget.reversed.toList())
        //                     // child: listItem(_items[0]['disussion'])
        //                     ))
        //             : Container(child: Text('No Discussions yet!!'));
        //       }
        //     }),
      ]),
    ));
  }

  listItem(List<DocumentSnapshot> item) {
    for (; widgetIndex < item[0]['disussion'].length; widgetIndex++) {
      commentData.insert(widgetIndex, {
        'comment': item[0]['disussion'][widgetIndex]['comment'],
        'date': item[0]['disussion'][widgetIndex]['date']
      });

      print(commentData[widgetIndex]['comment']);
      // print('itemval: ${item[0]['disussion'][widgetIndex]['comment']}');
      discussionListWidget.add(Column(children: <Widget>[
        Container(
          height: 50,
          width: MediaQuery.of(context).size.width * 5 / 6,
          child: Row(
            children: <Widget>[
              Container(
                height: 40,
                width: 40,
                // margin: EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image:
                          // AssetImage(''),
                          NetworkImage(
                              item[0]['disussion'][widgetIndex]['url']),
                      fit: BoxFit.fill),
                ),
              ),
              Expanded(
                  child: Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(item[0]['disussion'][widgetIndex]['comment']),
                ),
              )),
            ],
          ),
        ),
        Divider(
          indent: 5,
          endIndent: 5,
          color: Colors.black38,
          // thickness: 2,
        )
      ]));
    }
  }

  _addToDiscussions(String text) async {
    var comment = [
      {
        'comment': text,
        'date': DateTime.now().toUtc(),
        'url': "https://indiadidac.org/wp-content/uploads/2018/05/teacher.jpg"
      }
    ];
    DocumentReference documentReference =
        firestore.collection('classroom_${grade.id}').document('Session_1');
    firestore.runTransaction((transaction) async {
      await transaction.update(
          documentReference, {'disussion': FieldValue.arrayUnion(comment)});
    });
    // documentReference.get().then((doc){
    //   if(doc.exists){
    //     documentReference.updateData({'disussion':FieldValue.arrayUnion(comment)});
    //   }else{
    //     documentReference.setData({'disussion':FieldValue.arrayUnion(comment)});
    //   }
    // });
  }
}
