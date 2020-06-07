import 'dart:io';
import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:teacher_app/components/digicampus_appbar.dart';
import 'package:teacher_app/models/grade.dart';
import 'package:teacher_app/models/student.dart';
import 'package:teacher_app/models/teacher.dart';
import 'package:teacher_app/states/teacher_state.dart';
import 'package:video_player/video_player.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:chewie/chewie.dart';

class DiscussionsScreen extends StatefulWidget {
  // final Grade grade = Grade();
  // final Student student;
  final String date;
  final String grade;
  final int period;
  final bool uploadStatus;

  const DiscussionsScreen({Key key, this.date, this.grade, this.period, this.uploadStatus}) : super(key: key);

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
//  Grade grade = Grade.empty();
//  int id = 4001;
  int widgetIndex;
  Firestore firestore = Firestore.instance;
  VideoPlayerController _playerController ;
  Color color = Colors.grey;
  File imageURI;
  List<Asset> images = List<Asset>();
  String error = 'No Error Dectected';
  ValueNotifier<Duration> playtime = ValueNotifier(Duration(seconds: 0));
  bool showPlayerControls = true;
  bool uploading = false;
  bool uploaded = false;
  bool isFullScreen = false;
  bool loading = true;
   ChewieController _chewieController;

  // Future getImage() async {
  //   var image = await ImagePicker.pickImage(source: ImageSource.camera);

  //   setState(() {
  //     imageURI = image;
  //   });
  // }

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 10,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#00739e",
          statusBarColor: "#00739e",
          actionBarTitle: "Gallery",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    if (!mounted) return;

    setState(() {
      images = resultList;
    });
  }

  @override
  void initState() {
    uploaded = widget.uploadStatus;
    // TODO: implement initState
    widgetIndex = 0;
//    grade.setId(id);
    firestore.collection('grade_${widget.grade}').document('${widget.date}').get().then((value) {
      if(value == null)
        print('Video Error');
      else
        {
          _playerController =
          VideoPlayerController.network(value['url_period_${widget.period}'].toString())
            ..initialize().then((_) {
              // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
              setState(() {
                _playerController.play();
              });
            });
          _chewieController = ChewieController(
            allowedScreenSleep: false,
            allowFullScreen: true,
            fullScreenByDefault: false,
            deviceOrientationsAfterFullScreen: [
              DeviceOrientation.landscapeRight,
              DeviceOrientation.landscapeLeft,
              DeviceOrientation.portraitUp,
              DeviceOrientation.portraitDown,
            ],
            videoPlayerController: _playerController,
            autoInitialize: false,
            autoPlay: false,
            showControls: true,
//       customControls: getPlayerControls()
          );
          _chewieController.addListener(() {
            if (_chewieController.isFullScreen) {
              SystemChrome.setPreferredOrientations([
                DeviceOrientation.landscapeRight,
                DeviceOrientation.landscapeLeft,
              ]);
            }
          });
          _playerController.addListener(() async {
            await Future.delayed(Duration(seconds: 1));
            playtime.value = await _playerController.position;
          });
          setState(() {
            loading = false;
          });
        }
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    discussionListWidget.clear();
    _playerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TeacherState state = Provider.of<TeacherState>(context, listen: true);
    _teacher = state.teacher;
    return Scaffold(
        body:
             WillPopScope(
               onWillPop: (){
//                 _playerController.dispose();
                 return Future.value(true);
               },
               child: Container(
                child: Column(children: <Widget>[
                  Container(
                    color: Theme.of(context).primaryColor,
                    height: MediaQuery.of(context).padding.top,
                  ),
                  Container(

//            width: isFullScreen?MediaQuery.of(context).size.width:MediaQuery.of(context).size.height,
//            height: isFullScreen?MediaQuery.of(context).size.width:MediaQuery.of(context).size.height*0.3,
                    color: Colors.black,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: (){
//                          setState(() {
//                            showPlayerControls = !showPlayerControls;
//                          });
                          },
                          child: loading
                          ? Center(
                  child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor)))
                          :Container(
                            color: Colors.black,
//                      width: double.infinity,
//                      height: isFullScree
//                      n?double.infinity:MediaQuery.of(context).size.height*0.3,
                            child: AspectRatio(
                              aspectRatio: _playerController.value.aspectRatio,
                              child: Stack(
                                children: <Widget>[
                                  Center(
                                    child: _playerController.value.initialized
                                        ? AspectRatio(
                                      aspectRatio: _playerController.value.aspectRatio,
                                      child: GestureDetector(
                                        onTap: (){
                                          setState(() {
                                            showPlayerControls = !showPlayerControls;
                                          });
                                        },
                                        child: Chewie(

                                          controller: _chewieController,
                                        ),
                                      ),
                                    )
                                        : Container(),
                                  ),
//                                !showPlayerControls?Container():
//                                getPlayerControls(),
                                ],
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              (uploading)
                                  ?Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Theme.of(context).primaryColor),
                                ),
                              )
                                  :Container(
                                child: IconButton(
                                    icon: Icon(CupertinoIcons.video_camera_solid),
                                    onPressed: () async {
                                      File file =
                                      await FilePicker.getFile(type: FileType.video);
                                      print(file.path);
                                      showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (BuildContext context) {
                                          // return object of type Dialog
                                          return AlertDialog(
                                            title: new Text("Share video to Classroom?"),
                                            content: new Text("Class : 10 \nDate : ${widget.date}"),
                                            actions: <Widget>[
                                              // usually buttons at the bottom of the dialog
                                              new FlatButton(
                                                child: new Text("Close"),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              FlatButton(
                                                child: Text("Share"),
                                                onPressed: () async {
                                                  setState(() {
                                                    uploading = true;
                                                  });
                                                  Navigator.of(context).pop();
                                                  StorageReference storageReference;
                                                  if (file!=null) {
                                                    storageReference =
                                                        FirebaseStorage.instance.ref().child("videos/${widget.grade}/${widget.date}/${widget.period}");
                                                  }
                                                  final StorageUploadTask uploadTask = storageReference.putFile(file);
                                                  final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
                                                  final String url = (await downloadUrl.ref.getDownloadURL());
                                                  print("URL is $url");
                                                  updateDatabase(url);
                                                  setState(() {
                                                    uploaded = true;
                                                    uploading = false;
                                                  });
//                                        GET URL \/ \/ \/
//                                        StorageReference ref =
//                                        FirebaseStorage.instance.ref().child("videos/${widget.grade}/${widget.date}/${widget.period}");
//                                        String url2 = (await ref.getDownloadURL()).toString();
//                                        print(url2);
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }),
                              ),
                              Text(uploading ?'Uploading' :uploaded ?'Class Uploaded' :'Upload Class')
                            ],
                          ),

                        ),
                        SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.only(left:8),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(left:8),
                            child: Text(
                              'Raised Doubts',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w800
                              ),
                            ),
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
                                    onPressed: loadAssets,
                                    // _addToDiscussions(_textFieldController.text);
                                    // _textFieldController.clear();

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
                            IconButton(
                                icon: Icon(Icons.picture_as_pdf),
                                onPressed: () async {
                                  File file = await FilePicker.getFile(
                                      type: FileType.custom, allowedExtensions: ['pdf']);
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
                                      color = Colors.blue;
                                    });
                                  },
                                ))
                          ],
                        ),
                        SizedBox(height: 12),
               Expanded(
                 child: StreamBuilder<QuerySnapshot>(
                          // key: _key,
                          stream: firestore.collection('grade_${widget.grade}').snapshots(),
                          builder:
                              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData)
                              return Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Theme.of(context).primaryColor),
                                ),
                              );
                            else {
                              _items = snapshot.data.documents;
                              if(_items.isNotEmpty)
                              listItem(_items);
                              // print('item: ${_items[0]}');
                              // setState(() {
                              // AnimatedList.of(context).insertItem(0);
                              // Future.delayed(Duration(milliseconds: 200))
                              //     .then((value) => _listKey.currentState.insertItem(0));

                              // });
                              // return listItem(_items[0]);'
                              // commentData.addAll(_items[0]['']['']);
                              return (discussionListWidget.isNotEmpty)
                                  ? SingleChildScrollView(
                                          child: Column(
                                              children:
                                                  discussionListWidget.toList())
                                          // child: listItem(_items[0]['disussion'])
                                          )
                                  : Container(child: Text('No Discussions yet!!'));
                            }
                          }),
               ),
                      ],),
                    ),
                  )
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
        ),
             ));
  }

  listItem(List<DocumentSnapshot> items) {
    print('listITEM ----- ${items.length}');
    DocumentSnapshot item;
    for(int i=0; i<items.length; i++) {
      if(items[i].documentID == widget.date)  {
        item = items[i];
        print('ITEM FETCHED : $item');
      }
    }
      if(item != null && item.data.containsKey('discussion_period_${widget.period}')){
        print(item['discussion_period_${widget.period}'].length);
        for (; widgetIndex < item['discussion_period_${widget.period}'].length; widgetIndex++) {
          commentData.insert(widgetIndex, {
            'comment': item['discussion_period_${widget
                .period}'][widgetIndex]['comment'],
            'date': item['discussion_period_${widget.period}'][widgetIndex]['date']
          });

          print(item['discussion_period_${widget
              .period}'][widgetIndex]['comment']);
          // print('itemval: ${item[0]['disussion'][widgetIndex]['comment']}');
          discussionListWidget.add(Column(children: <Widget>[
            Container(
              height: 50,
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 5 / 6,
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
                              item['discussion_period_${widget
                                  .period}'][widgetIndex]['url']),
                          fit: BoxFit.fill),
                    ),
                  ),
                  Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        height: 50,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(item['discussion_period_${widget
                              .period}'][widgetIndex]['comment']),
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
  }

  updateDatabase(String url) {
    print('UODATE DATABASE');
    DocumentReference documentReference =
    firestore.collection('grade_${widget.grade}').document('${widget.date}');
    firestore.collection('grade_${widget.grade}').getDocuments().then((value) {
      value.documents.forEach((element) {
      });
      if(value.documents.isEmpty)
        firestore.runTransaction((transaction) async {
          await transaction.set(
              documentReference, {'period_${widget.period}': url});
          print('---- >>>SET');
        });
      else
        firestore.collection('grade_${widget.grade}').document('${widget.date}').get().then((value) {
          if(value.exists)
            firestore.runTransaction((transaction) async {
              await transaction.update(
                  documentReference, {'url_period_${widget.period}': url});
              print('--- >>> UPDATED ');
            });
          else
            firestore.runTransaction((transaction) async {
              await transaction.set(
                  documentReference, {'url_period_${widget.period}': url});
              print('--- >>> UPDATED ');
            });
        });

    });
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
    firestore.collection('grade_${widget.grade}').document('${widget.date}');
    firestore.collection('grade_${widget.grade}').getDocuments().then((value) {
      if(value.documents.isEmpty)
      firestore.runTransaction((transaction) async {
        await transaction.set(
            documentReference, {'discussion_period_${widget.period}': FieldValue.arrayUnion(comment)});
      });
    else
      firestore.runTransaction((transaction) async {
        await transaction.update(
            documentReference, {'discussion_period_${widget.period}': FieldValue.arrayUnion(comment)});
      });
  });
  }

  Widget getPlayerControls(){
    return Container(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: ValueListenableBuilder<Duration>(
              valueListenable: playtime,
              builder: (context, val, _) {
                print(_playerController.value.duration);
                print(val);
                return Text(
                  '${val.inMinutes} : ${val.inSeconds % 60}',
                  style: TextStyle(color: Colors.white),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: ValueListenableBuilder<Duration>(
              builder: (context, val, _) {
                return Text(
                  '${_playerController.value.duration.inHours}:${_playerController.value.duration.inMinutes}:${_playerController.value.duration.inSeconds % 60}',
                  style: TextStyle(color: Colors.white),
                );
              },
              valueListenable: playtime,
            ),
          ),
          Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  })),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    icon:
                    Icon(Icons.fast_rewind, color: Colors.white),
                    onPressed: () async {
                      Duration duration = Duration(
                          seconds: (await _playerController.position)
                              .inSeconds -
                              10);
                      _playerController.seekTo(duration);
                    }),
                FloatingActionButton(
//                  backgroundColor:
//                  Theme.of(context).primaryColor.withOpacity(0.7),
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
                IconButton(
                    icon: Icon(
                      Icons.fast_forward,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      Duration duration = Duration(
                          seconds: (await _playerController.position)
                              .inSeconds +
                              10);
                      _playerController.seekTo(duration);
                    })
              ],
            ),
          ),
          Align(
              alignment: Alignment.topRight,
              child: IconButton(
                  icon: Icon(
                    Icons.fullscreen,
                    size: 30,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    _chewieController.toggleFullScreen();
                  }))
        ],
      ),
    );

  }
}
