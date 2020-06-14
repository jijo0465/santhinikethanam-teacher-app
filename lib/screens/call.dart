import 'dart:async';
import 'dart:convert';
//import 'dart:io' as io;

//import 'package:audioplayers/audioplayers.dart';
import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:path_provider/path_provider.dart';
//import 'dart:async';
//import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diagonal_scrollview/diagonal_scrollview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screen_recording/flutter_screen_recording.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:teacher_app/components/digicampus_appbar.dart';
import 'package:teacher_app/components/live_stream_settings.dart';
import 'package:teacher_app/models/grade.dart';
import 'package:http/http.dart' as http;

class CallPage extends StatefulWidget {
  // final String channelName;
  final int id;
  const CallPage({Key key, this.id}) : super(key: key);

  @override
  _CallPageState createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> with SingleTickerProviderStateMixin {
  static final _users = <int>[];
  final _infoStrings = <String>[];
  final double _minScale = .6;
  final double _maxScale = 3;
  final TextEditingController _textFieldController =
  new TextEditingController();
  String channelName;
  DiagonalScrollViewController _controller;
  AnimationController _animationController;
  Animation _animation;
  Firestore firestore = Firestore.instance;
  DocumentSnapshot _participantSnapshot;
  DocumentSnapshot _discussionSnapshot;
  List<Widget> discussionListWidget = [];
  List<Map<String, dynamic>> _discussionData = [];
  List<String> participantName = [];
  Grade grade = Grade.empty();
  int widgetIndex = 0;
  int broadcasterUid;
  String resourceId;
  String sid;
  String videoPath;
  String _platformVersion = 'Unknown';
  final FlutterFFmpeg _flutterFFmpeg = new FlutterFFmpeg();
//  double appBarHeight = 100;
  double _boxSizeWidth = 520.0;
  double _boxSizeHeight = 104.0;

//  ValueNotifier<bool> onShowToolbar = ValueNotifier(true);
//  ValueNotifier<bool> onCheckParticipants = ValueNotifier(false);
//  ValueNotifier<bool> recording = ValueNotifier(false);
  bool onShowToolbar = true;
//  bool onShowDiscussions = false;
  bool onCheckParticipants = false;
  bool muted = false;
  bool record = false;
  Color discussionFieldColor = Colors.grey;
  Color recordButtonColor = Colors.redAccent;
  String date = DateFormat('dd-MM-yyyy').format(DateTime.now());
  FlutterAudioRecorder _recorder;
//  Recording _current;
  RecordingStatus _currentStatus = RecordingStatus.Unset;
  LocalFileSystem localFileSystem = LocalFileSystem();


  @override
  void dispose() {
    // clear users
    _animationController.dispose();
    _users.clear();
    discussionListWidget.clear();
    // destroy sdk
//    _animationController.dispose();
    AgoraRtcEngine.leaveChannel();
    AgoraRtcEngine.destroy();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    grade.setId(widget.id);
    _animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 900)
    );
    _animation = Tween(
        begin: 1.0,
        end: 0.0).animate(_animationController);
//    _animationController.forward();
    // initialize agora sdk
//    _initAudio();
    initialize();
    Future.delayed(Duration(seconds: 10)).then((value) {
      setState(() {
        onShowToolbar = false;
      });
      _animationController.forward();
    });
//    initPlatformState();
  }

//  Future<void> initPlatformState() async {
//    String platformVersion;
//    // Platform messages may fail, so we use a try/catch PlatformException.
//    try {
//      platformVersion = await FlutterScreenRecording.platformVersion;
//    } on PlatformException {
//      platformVersion = 'Failed to get platform version.';
//    }
//
//    // If the widget was removed from the tree while the asynchronous platform
//    // message was in flight, we want to discard the reply rather than calling
//    // setState to update our non-existent appearance.
//    if (!mounted) return;
//
//    setState(() {
//      _platformVersion = platformVersion;
//    });
//  }

  Future<void> initialize() async {
    if (APP_ID.isEmpty) {
      setState(() {
        _infoStrings.add(
          'APP_ID missing, please provide your APP_ID in settings.dart',
        );
        _infoStrings.add('Agora Engine is not starting');
      });
      return;
    }
    _addAgoraEventHandlers();
    await _initAgoraRtcEngine();
  }

  /// Create agora sdk instance and initialize
  Future<void> _initAgoraRtcEngine() async {
    await AgoraRtcEngine.create(APP_ID);
    await AgoraRtcEngine.enableVideo();
    await AgoraRtcEngine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await AgoraRtcEngine.setClientRole(ClientRole.Broadcaster);
    await AgoraRtcEngine.enableWebSdkInteroperability(true);
    await AgoraRtcEngine.joinChannel(
        null,
        'class_${grade.id}',
        null,
        0);
    // await AgoraRtcEngine.enableWebSdkInteroperability(true);
  }

  /// Add agora event handlers
  void _addAgoraEventHandlers() {
    AgoraRtcEngine.onError = (dynamic code) {
      setState(() {
        final info = 'onError: $code';
        _infoStrings.add(info);
      });
      Future.delayed(Duration(seconds: 3)).then((value) {
        setState(() {
          _infoStrings.removeLast();
        });
      });
    };

    AgoraRtcEngine.onJoinChannelSuccess = (String channel,
        int uid,
        int elapsed,) {
      channelName = channel;
      firestore.collection('live').document('grade_${grade.id}').setData({'liveBroadcastUserId': {'users': null}},merge: true);
      firestore.collection('live').document('grade_${grade.id}')
          .setData({'liveBroadcastChannelId': uid},merge: true)
          .then((value) {
        startRecording(uid);
        broadcasterUid = uid;
        setState(() {
          final info = 'onJoinChannel: $channel, uid: $uid';
          _infoStrings.add(info);
        });
      });

      Future.delayed(Duration(seconds: 3)).then((value) {
        setState(() {
          _infoStrings.removeLast();
        });
//        startRecording(uid);
      });
    };

    AgoraRtcEngine.onLeaveChannel = () {
      setState(() {
        _infoStrings.add('onLeaveChannel');
        _users.clear();
      });
      Future.delayed(Duration(seconds: 3)).then((value) {
        setState(() {
          _infoStrings.removeLast();
        });
      });
    };

    AgoraRtcEngine.onUserJoined = (int uid, int elapsed) {
      setState(() {
        final info = 'userJoined: $uid';
        _infoStrings.add(info);
        _users.add(uid);
      });
      print(_users[0]);
      Future.delayed(Duration(seconds: 3)).then((value) {
        setState(() {
          _infoStrings.removeLast();
        });
      });
    };

    AgoraRtcEngine.onUserOffline = (int uid, int reason) {
      setState(() {
        final info = 'userOffline: $uid';
        _infoStrings.add(info);
        _users.remove(uid);
      });
      Future.delayed(Duration(seconds: 3)).then((value) {
        setState(() {
          _infoStrings.removeLast();
        });
      });
    };

    AgoraRtcEngine.onFirstRemoteVideoFrame = (int uid,
        int width,
        int height,
        int elapsed,) {
      print("firstRemoteVideo: $uid ${width}x $height");
      setState(() {
        final info = 'firstRemoteVideo: $uid ${width}x $height';
        _infoStrings.add(info);
      });
      Future.delayed(Duration(seconds: 3)).then((value) {
        setState(() {
          _infoStrings.removeLast();
        });
      });
    };
  }

  /// Helper function to get list of native views
  // List<Widget> _getRenderViews() {
  //   final List<AgoraRenderWidget> list = [
  //     AgoraRenderWidget(0, local: true, preview: true),
  //   ];
  //   _users.forEach((int uid) => list.add(AgoraRenderWidget(uid)));
  //   return list;
  // }

  /// Video view wrapper
  // Widget _videoView(view) {
  //   return Expanded(child: Container(child: view));
  // }

  /// Video view row wrapper
  // Widget _expandedVideoRow(List<Widget> views) {
  //   final wrappedViews = views.map<Widget>(_videoView).toList();
  //   return Expanded(
  //     child: Row(
  //       children: wrappedViews,
  //     ),
  //   );
  // }

  /// Video layout wrapper
  // Widget _viewRows() {
  //   final views = _getRenderViews();
  //   switch (views.length) {
  //     case 1:
  //       return Container(
  //           child: Column(
  //         children: <Widget>[_videoView(views[0])],
  //       ));
  //     case 2:
  //       return Container(
  //           child: Column(
  //         children: <Widget>[
  //           _expandedVideoRow([views[0]]),
  //           _expandedVideoRow([views[1]])
  //         ],
  //       ));
  //     case 3:
  //       return Container(
  //           child: Column(
  //         children: <Widget>[
  //           _expandedVideoRow(views.sublist(0, 2)),
  //           _expandedVideoRow(views.sublist(2, 3))
  //         ],
  //       ));
  //     case 4:
  //       return Container(
  //           child: Column(
  //         children: <Widget>[
  //           _expandedVideoRow(views.sublist(0, 2)),
  //           _expandedVideoRow(views.sublist(2, 4))
  //         ],
  //       ));
  //     default:
  //   }
  //   return Container();
  // }

  /// VideoView layout
  Widget _viewVideo() {
    return Container(
      child: AgoraRtcEngine.createNativeView((viewId) {
        AgoraRtcEngine.setupLocalVideo(viewId, VideoRenderMode.Fit);
      }),
    );
  }

  /// Toolbar layout
  Widget _toolbar() {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      alignment: Alignment.bottomCenter,
//      padding: const EdgeInsets.symmetric(vertical: 48),
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
//          Flexible(
//            flex: 1,
//            child: RaisedButton(
//                shape: CircleBorder(side: BorderSide(color: Colors.white30)),
//                color: Colors.grey,
//                onPressed: onCheckParticipants ? null : () {
//                  setState(() {
//                    onShowDiscussions = !onShowDiscussions;
//                  });
//                  if(!onShowDiscussions)
//                    Future.delayed(Duration(seconds: 10)).then((value) {
//                      if(!onCheckParticipants)  {
//                        _animationController.forward();
//                        setState(() {
//                          onShowToolbar = false;
//                        });
//                      }
//                    });
//                },
//                child: Icon(
//                  Icons.chat,
//                  color: Colors.black54,
//                  size: 40.0,
//                )),
//          ),
          Flexible(
            flex: 2,
            child: Container(
              child: IconButton(
                padding: EdgeInsets.all(16),
                onPressed: () {
                  _onCallEnd(context);
//                  Navigator.of(context).pop();
                },
//                  backgroundColor: Colors.white30,
                icon: Icon(Icons.add_to_home_screen,color: Colors.white,size: 30,),
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: IconButton(
//                shape: CircleBorder(side: BorderSide(color: Colors.white30)),
                color: Theme
                    .of(context)
                    .primaryColor
                    .withOpacity(0.6),
                onPressed: onCheckParticipants ? null : _onToggleMute,
                icon: Icon(
                  muted ? Icons.mic_off : Icons.mic,
                  color: muted ? Colors.red : Colors.white70,
                  size: 40,
                )),
          ),
          Flexible(
            flex: 3,
            child:TweenAnimationBuilder(
              tween: ColorTween(begin: Theme.of(context)
                        .primaryColor
                        .withOpacity(0.6),end: recordButtonColor),
              duration: Duration(seconds: 1),
              onEnd: (){
                if(!record)
                setState(() {
                  recordButtonColor = recordButtonColor == Colors.redAccent
                      ?Theme
                        .of(context)
                        .primaryColor
                        .withOpacity(0.6)
                      :Colors.redAccent;
                });
                else {
                  recordButtonColor = Colors.redAccent;
                }
              },
              builder: (_, Color color, __){
                return FloatingActionButton(
//              shape: CircleBorder(side: BorderSide(color: Colors.white30)),
                  backgroundColor: Colors.transparent,
                  onPressed: onCheckParticipants ? null : ()
//              => _onCallEnd(context),
                  {
//                setState(() {
//                  record = !record;
//                });
//                record ? startRecording(broadcasterUid)
//                    : stopRecording(broadcasterUid);

//                record ? _startVideoRecording()
//                    : _stopVideoRecording();
                  },
                  child: Icon(
                    CupertinoIcons.circle_filled,
                    size: 60,
                    color: color
//                    recording.value ? Colors.redAccent : Theme
//                        .of(context)
//                        .primaryColor
//                        .withOpacity(0.6),
//                size: 60.0,
                  ),
                );
              },
            )
          ),
          Flexible(
            flex: 2,
            child: IconButton(
//                shape: CircleBorder(side: BorderSide(color: Colors.white30)),
                color: Theme
                    .of(context)
                    .primaryColor
                    .withOpacity(0.6),
                onPressed: onCheckParticipants ? null : _onSwitchCamera,
                icon: Icon(
                  Icons.switch_camera,
                  color: Colors.white70,
                  size: 40.0,
                )),
          ),
          Flexible(
            flex: 2,
            child: IconButton(
//                shape: CircleBorder(side: BorderSide(color: Colors.white30)),
                color: Theme
                    .of(context)
                    .primaryColor
                    .withOpacity(0.6),
                onPressed: () {
                  setState(() {
                    onCheckParticipants = !onCheckParticipants;
                  });
                  if (!onCheckParticipants)
                    Future.delayed(Duration(seconds: 10)).then((value) {
                      _animationController.forward();
                      setState(() {
                        onShowToolbar = false;
                      });
                    });
                },
                icon: Icon(
                  Icons.group,
                  color: Colors.white70,
                  size: 40.0,
                )),
          ),
        ],
      ),
    );
  }

  /// Info panel to show logs
  Widget _panel() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60),
      alignment: Alignment.bottomCenter,
      child: FractionallySizedBox(
        heightFactor: 0.5,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 48),
          child: ListView.builder(
            reverse: true,
            itemCount: _infoStrings.length,
            itemBuilder: (BuildContext context, int index) {
              if (_infoStrings.isEmpty) {
                return null;
              }
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 3,
                  horizontal: 10,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 5,
                        ),
                        decoration: BoxDecoration(
                          color:
                          Theme
                              .of(context)
                              .primaryColor
                              .withOpacity(0.3),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          _infoStrings[index],
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _onCallEnd(BuildContext context) {
    showDialog(
//      barrierDismissible: true ,
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Text('Alert'),
          content: Text('End Class?'),
          actions: <Widget>[
            CupertinoDialogAction(
                child: Text('Upload Class'),
                onPressed: () {
                  stopRecording(broadcasterUid,true);
//                  if(record)
//                    _stopVideoRecording();
                  firestore.collection('live').document('grade_${grade.id}')
                      .setData({'liveBroadcastChannelId': null},merge: true);
                  Navigator.pop(context);
                  Navigator.pop(context);
                }),
            CupertinoDialogAction(
              child: Text('Exit'),
              onPressed: (){
                stopRecording(broadcasterUid,false);
                firestore.collection('live').document('grade_${grade.id}')
                    .setData({'liveBroadcastChannelId': null},merge: true);
                Navigator.pop(context);
                Navigator.pop(context);
              },),
          ],
        ));
  }

  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    AgoraRtcEngine.muteLocalAudioStream(muted);
  }

  void _onSwitchCamera() {
    AgoraRtcEngine.switchCamera();
  }

  List<Widget> _getChildrenColumn(List<dynamic> item) {
    List<Widget> children;
    int cubeId = 0;
    int totalParticipants = item != null ? item.length : 0;
    for (num x = 0; x < totalParticipants; x++) {
      
    }
  }

  List<Widget> _getChildren(List<dynamic> item) {
    List<Widget> children = [];
    Color childColor = Colors.blueGrey;
    double childSize = 80;
    double childMargin = 20;
    num numChildrenX;
    num numChildrenY;
    int cubeId = 0;
    int totalParticipants = item != null ? item.length : 0;
    numChildrenY = (totalParticipants / 5).ceil();
    for (int i = 0; i < totalParticipants; i++)
      participantName.insert(i, item[i].toString());
//    participantName.sort();
    print('PARTICIPANTS: $totalParticipants');
    for (num x = 0; x < numChildrenY; x++) {
      numChildrenX =
      (totalParticipants - (x * 5)) > 5 ? 5 : totalParticipants - (x * 5);
      for (num y = 0; y < numChildrenX; y++) {
        Widget cube = Container(
//          width: childSize+20,
//          height: childSize,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
//            color: childColor,
          ),
          child: Center(
            child: Container(
              padding: EdgeInsets.all(8),
              child: Text(
//              (cubeId++).toString(),
                '${cubeId+1}. ${participantName[cubeId++]}',
                style: TextStyle(color: Colors.white, fontSize: 18),
                overflow: TextOverflow.clip,
              ),
            ),
          ),
        );
        children.add(Padding(
          padding: EdgeInsets.all(0),
//          left: childMargin + (childMargin + childSize) * y,
//          top: childMargin + (childMargin + childSize) * x,
          child: cube,
        ));
      }
    }
    return children;
  }

//  _listDiscussion(var item) {
//    for (; widgetIndex < item['discussion'].length; widgetIndex++) {
//      _discussionData.insert(widgetIndex, {
//        'id': item['discussion'][widgetIndex]['id'],
//        'text': item['discussion'][widgetIndex]['text'],
//        'time': item['discussion'][widgetIndex]['time']
//      });
//      print(_discussionData[widgetIndex]['text']);
//      discussionListWidget.add(Column(children: <Widget>[
//        Container(
//          height: 50,
//          width: MediaQuery
//              .of(context)
//              .size
//              .width * 5 / 6,
//          child: Row(
//            children: <Widget>[
//              Container(
//                height: 40,
//                width: 40,
//                // margin: EdgeInsets.only(left: 20),
//                decoration: BoxDecoration(
//                  shape: BoxShape.circle,
//                  image: DecorationImage(
//                      image:
//                      NetworkImage(
//                          'https://i.pinimg.com/236x/e4/f7/5e/e4f75e2f6b1ef0afa711278b655dfe4a.jpg'),
//                      fit: BoxFit.fill),
//                ),
//              ),
//              Expanded(
//                  child: Container(
//                    padding: EdgeInsets.only(left: 20, right: 20),
//                    height: 50,
//                    width: MediaQuery
//                        .of(context)
//                        .size
//                        .width,
//                    child: Align(
//                      alignment: Alignment.centerLeft,
//                      child: Text(item['discussion'][widgetIndex]['text']),
//                    ),
//                  )),
//            ],
//          ),
//        ),
//        Divider(
//          indent: 5,
//          endIndent: 5,
//          color: Colors.black38,
//          // thickness: 2,
//        )
//      ]));
//    }
//  }

//  _addToDiscussions(String text) async {
//    var addText = [
//      {'id': 3001, 'text': text, 'time': DateTime.now().toUtc()}
//    ];
//    DocumentReference documentReference =
//    firestore.collection('live').document('subject_date_hr');
//    firestore.runTransaction((transaction) async {
//      await transaction.update(
//          documentReference, {'discussion': FieldValue.arrayUnion(addText)});
//    });
    // documentReference.get().then((doc){
    //   if(doc.exists){
    //     documentReference.updateData({'disussion':FieldValue.arrayUnion(comment)});
    //   }else{
    //     documentReference.setData({'disussion':FieldValue.arrayUnion(comment)});
    //   }
    // });
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: WillPopScope(
        onWillPop: () {
          _onCallEnd(context);
          return Future.value(true);
        },
        child: Center(
          child: Stack(
            children: <Widget>[
              // _viewRows(),
              _viewVideo(),
              _panel(),
              FadeTransition(
                  opacity: _animation,
                  child: _toolbar()),
//            Positioned(
//              top: MediaQuery.of(context).padding.top,
//              child: Container(
//                child: IconButton(
//                  padding: EdgeInsets.all(16),
//                  onPressed: () {
//                    _onCallEnd(context);
//                    Navigator.of(context).pop();
//                  },
////                  backgroundColor: Colors.white30,
//                  icon: Icon(Icons.add_to_home_screen,color: Colors.red,size: 28,),
//                ),
//              ),
//            ),
//            AnimatedContainer(
//              duration: Duration(milliseconds: 900),
//              height: onShowToolbar ? 110 - MediaQuery
//                  .of(context)
//                  .padding
//                  .top : 0,
//              curve: Curves.easeIn,
//              child: DigiCampusAppbar(
//                icon: Icons.close,
//                onDrawerTapped: () {
//                  _onCallEnd(context);
////                  Navigator.of(context).pop();
//                },
//              ),
//            ),
              onShowToolbar ? Container()
                  : Container(
                child: GestureDetector(
                    onTap: () {
                      _animationController.reverse();
                      setState(() {
                        onShowToolbar = true;
                      });
                      Future.delayed(Duration(seconds: 10)).then((value) {
                        if (!onCheckParticipants) {
                          _animationController.forward();
                          setState(() {
                            onShowToolbar = false;
                          });
                        }
                      });
                    },
                    behavior: HitTestBehavior.translucent,
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                      ),
                    )
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                          sigmaX: onCheckParticipants ? 25 : 0,
                          sigmaY: onCheckParticipants ? 25 : 0),
                      child: onCheckParticipants
                          ? StreamBuilder<QuerySnapshot>(
                          stream: firestore.collection('live').snapshots(),
                          builder: (BuildContext context, AsyncSnapshot<
                              QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Theme
                                          .of(context)
                                          .primaryColor),
                                ),
                              );
                            }
                            else {
                              for (int i = 0; i <
                                  snapshot.data.documents.length; i++) {
                                if (snapshot.data.documents[i].documentID ==
                                    'grade_${grade.id}')
                                  _participantSnapshot =
                                  snapshot.data.documents[i];
                              }
                              if (_participantSnapshot['liveBroadcastUserId']['users'] != null) {
                                _boxSizeHeight = 104.0 *
                                    (_participantSnapshot['liveBroadcastUserId']['users'].length / 5)
                                        .ceil();
                                return Container(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width - 40,
                                    height: MediaQuery
                                        .of(context)
                                        .size
                                        .height * 0.6,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.black
                                          .withOpacity(
                                          onCheckParticipants ? 0.4 : 0.0),
                                    ),
                                    child:
                                    SingleChildScrollView(
                                      padding: EdgeInsets.all(8),
                                      child: Column(
                                        children: _getChildren(_participantSnapshot['liveBroadcastUserId']['users']),
                                      ),
                                    )
//                                    DiagonalScrollView(
//                                        enableFling: true,
//                                        enableZoom: true,
//                                        flingVelocityReduction: 0.3,
//                                        minScale: _minScale,
//                                        maxScale: _maxScale,
//                                        maxHeight: _boxSizeHeight,
//                                        maxWidth: _boxSizeWidth,
//                                        onCreated: (
//                                            DiagonalScrollViewController controller) {
//                                          _controller = controller;
//                                        },
//                                        child:
//                                        Container(
//                                          height: _boxSizeHeight,
//                                          width: _boxSizeWidth,
//                                          child: Stack(
//                                            children: _getChildren(
//                                                _participantSnapshot['liveBroadcastUserId']['users']),
//                                          ),
//                                        )
//                                    )
                                );
                              }
                              else {
                                return Container(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width - 40,
                                    height: MediaQuery
                                        .of(context)
                                        .size
                                        .height * 0.6,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.black
                                          .withOpacity(
                                          onCheckParticipants ? 0.4 : 0.0),
                                    ),
                                    child:
                                    Center(
                                      child: Text('Students yet to join!',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 18)),
                                    ));
                              }
                            }
                          }
                      )
//                        : onShowDiscussions
//                        ? Container(
//                            width: MediaQuery.of(context).size.width - 40,
//                            height: MediaQuery.of(context).size.height * 0.6,
//                            padding: EdgeInsets.all(12),
//                            decoration: BoxDecoration(
//                            borderRadius: BorderRadius.circular(12),
//                            color: Colors.white
//                                .withOpacity(onShowDiscussions ? 0.4 : 0.0),
//                            ),
//                            child: Column(
//                              children: [
//                                Center(
//                                  child: Text('Discussions',textScaleFactor: 1.3,)
//                                ),
//                                Expanded(
//                                  child: Container(
//                                    child: StreamBuilder<QuerySnapshot>(
//                                    stream: firestore.collection('live').snapshots(),
//                                    builder: (context, snapshot) {
//                                      if (!snapshot.hasData)
//                                        return Center(
//                                          child: CircularProgressIndicator(
//                                            valueColor: AlwaysStoppedAnimation<Color>(
//                                                Theme.of(context).primaryColor),
//                                          ),
//                                        );
//                                      else{
//                                        for(int i=0; i<snapshot.data.documents.length; i++)
//                                          if(snapshot.data.documents[i].documentID == 'subject_date_hr')
//                                            _discussionSnapshot = snapshot.data.documents[i];
//                                          _listDiscussion(_discussionSnapshot);
//                                        return (_discussionSnapshot['discussion'].isNotEmpty)
//                                            ? SingleChildScrollView(
//                                                child: Column(
//                                                    children: discussionListWidget.toList())
//                                              // child: listItem(_items[0]['disussion'])
//                                            )
//                                            : Center(child: Container(child: Text('No Discussions yet!!')));}
//                                    }
//                          ),
//                                  ),
//                                ),
//                                Row(
//                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                  children: <Widget>[
//                                    Container(
//                                      height: 40,
//                                      width: MediaQuery.of(context).size.width*0.60,
//                                      // decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
//                                      child: TextField(
//                                        onChanged: (text) {
//                                          if (text == '') {
//                                            setState(() {
//                                              discussionFieldColor = Colors.grey;
//                                            });
//                                          } else {
//                                            setState(() {
//                                              discussionFieldColor = Colors.deepOrange[300];
//                                            });
//                                          }
//                                        },
//                                        controller: _textFieldController,
//                                        // textAlignVertical: TextAlignVertical.center,
//                                        textAlign: TextAlign.start,
//                                        cursorColor: Colors.blue,
//                                        decoration: InputDecoration(
//                                          hintText: 'add to discussions...',
//                                          contentPadding: EdgeInsets.symmetric(horizontal: 12),
//                                          border: OutlineInputBorder(
//                                            borderRadius: BorderRadius.circular(20),
//                                          ),
//                                          suffixIcon: IconButton(
//                                            onPressed: () {
//                                              _addToDiscussions(_textFieldController.text);
//                                              _textFieldController.clear();
//                                            },
//                                            icon: Icon(Icons.camera_alt),
//                                            color: Colors.blue,
//                                          ),
//                                        ),
//
//                                        // autofocus: true,
//                                        // onSubmitted: (text) {
//                                        //   // print(text);
//                                        //   _addToDiscussions(text);
//                                        //   _textFieldController.clear();
//                                        //   // text = '';
//                                        // },
//                                      ),
//                                    ),
//                                    Container(
//                                        height: 40,
//                                        width: 40,
//                                        decoration: BoxDecoration(
//                                            shape: BoxShape.circle, color: Colors.grey[300]),
//                                        child: GestureDetector(
//                                          child: Icon(Icons.send, color: discussionFieldColor),
//                                          behavior: HitTestBehavior.translucent,
//                                          onTap: () {
//                                            _addToDiscussions(_textFieldController.text);
//                                            _textFieldController.clear();
//                                            setState(() {
//                                              discussionFieldColor = Colors.grey;
//                                            });
//                                          },
//                                        ))
//                                  ],
//                                ),
//                              ],
//                            ),
//                        )
                          : Container(),
                    ),
                  ),
                ),
              )
              //   }
              // })
            ],
          ),
        ),
      ),
    );
  }

  updateDatabaseVideo(String url) {
    int periodNo;
    String saveFormattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
    firestore.collection('grade_${grade.id}').document('$saveFormattedDate').get().then((value) {
      periodNo = value.data == null  ?1 :value.data.length+1;
      firestore.collection('grade_${grade.id}').document('$saveFormattedDate').setData(
          {'period_$periodNo': {'pdno': '$periodNo', 'videoUrl': url}},merge: true
      );
    });
    }
//
  Future<void> startRecording(int uid) async {
    print("Starting Recording$channelName");
    String url = 'http://api.monkmindsolutions.com/start_recording/$uid/$channelName';
    Map<String, String> headers = {"Content-type": "application/json"};
//    Map<String, String> params = {"uid": uid.toString()};
//    String data = jsonEncode(params);

    http.get(url, headers: headers).then((response) async {
      await Future.delayed(Duration(seconds: 5));
      getRecordingStatus(uid);
      // print(response.body);
      // resourceId = json.decode(response.body)['resourceId'];
      // sid = json.decode(response.body)['resourceId'];
    }).catchError((error) => print(error));

  }

  Future<dynamic> getRecordingStatus(int uid){
    print("Getting Status");
    String url = 'http://api.monkmindsolutions.com/get_status/$uid/$channelName';
    Map<String, String> headers = {"Content-type": "application/json"};
//    Map<String, String> params = {"uid": uid.toString()};
//    String data = jsonEncode(params);

    http.get(url, headers: headers).then((response) {
//      getRecordingStatus();
       print(response.body);
       var status = jsonDecode(response.body);
       print('STATUS \n$status');
       print('STATUS CODE : ${status['serverResponse']['status']}');
       if(status['serverResponse']['status'] == 5){
         print('STATUS CODE : ${status['serverResponse']['status']}');
         setState(() {
           record = true;
         });
       }else{
         throw Exception('Recording Not started');
       }
      // sid = json.decode(response.body)['resourceId'];
    }).catchError((error) => showCupertinoDialog(context: context, builder:(context) {
      return CupertinoAlertDialog(
        title: Text('Recording Not Started'),
        actions: [
          FlatButton(child: Text('Exit'),onPressed: (){
            Navigator.of(context).pop();
            _onCallEnd(context);
          },),
          FlatButton(child: Text('Try Again'),onPressed: () async {
            Navigator.of(context).pop();
            AgoraRtcEngine.leaveChannel();
            await AgoraRtcEngine.joinChannel(
                null,
                'class_${grade.id}',
                null,
                0);
          },)
        ],
      );
    }, ));
  }

  Future<void> stopRecording(int uid, bool rec) async {
    print('Stopping Recording....$channelName');
    await Future.delayed(Duration(seconds: 5));
    String url = 'http://api.monkmindsolutions.com/stop_recording/$uid/$channelName';
    Map<String, String> headers = {"Content-type": "application/json"};
//    Map<String, dynamic> params = {"resourceId": "$resourceId", "sid": "$sid"};
//    String data = jsonEncode(params);
    await http.get(url, headers: headers).then((response) {
      print(response.body);
      var res = json.decode(response.body);
      String url = "https://digicampus.s3.us-east-2.amazonaws.com/" +
          res['serverResponse']['fileList'];
      if (rec)
      updateDatabaseVideo(url);
    }).catchError((error) => print(error));
  }

//  _startVideoRecording() async {
//      bool start = await FlutterScreenRecording.startRecordScreen("${DateTime.now().day}_${DateTime.now().month}_${DateTime.now().year}");
////      _startAudio();
//      print('RECORD STATUS : $start');
//    print('audio STARTED');
//    await _recorder.start();
//    var recording = await _recorder.current(channel: 0);
//    print('RECORDING AUDIO STARTED : :: : : ${recording.path}');
//  }

//  _stopVideoRecording() async {
//    String path = await FlutterScreenRecording.stopRecordScreen;
////    _stopAudio();
//    var result = await _recorder.stop();
//    print('AUDIO Stopped');
//    print("Stop recording: ${result.path}");
//    print("Stop recording: ${result.duration}");
//    print('AUDIO RECORDED PATH${result.path}');
//    print('Recorded File : $path');
//    _flutterFFmpeg.execute("-i $path -i ${result.path} -c:v copy -c:a copy -codec: copy /storage/emulated/0/DCIM/output.mp4").then((rc) => print("FFmpeg process exited with rc $rc"));
//
//  }

//  _initAudio() async {
////    if(await FlutterAudioRecorder.hasPermissions){
//    print('Audio INITIALIZED');
////    _recorder = FlutterAudioRecorder("${DateTime.now().millisecondsSinceEpoch.toString()}_audio", audioFormat: AudioFormat.AAC); // or AudioFormat.WAV
////    await _recorder.initialized;
////    setState(() {
////    });}
////    else{
////      Scaffold.of(context).showSnackBar(
////          new SnackBar(content: new Text("You must accept permissions")));
////    }
//
////    try {
////      if (await FlutterAudioRecorder.hasPermissions) {
//        String audioPath = "/storage/emulated/0/DCIM/${DateTime.now().millisecondsSinceEpoch.toString()}_audio";
////        Directory appDocDirectory;
//////        appDocDirectory = await getApplicationDocumentsDirectory();
////        appDocDirectory = await getExternalStorageDirectory();
////        if (Platform.isIOS) {
////          appDocDirectory = await getApplicationDocumentsDirectory();
////        } else {
////          appDocDirectory = await getExternalStorageDirectory();
////          print('PlatForM DETERMINED!!\n$appDocDirectory');
////        }
////    final directory = await getApplicationDocumentsDirectory();
//
//
//        // can add extension like ".mp4" ".wav" ".m4a" ".aac"
////        audioPath = directory.path +
////            audioPath;
//        print(audioPath);
////            +
////            DateTime.now().millisecondsSinceEpoch.toString();
//
//        // .wav <---> AudioFormat.WAV
//        // .mp4 .m4a .aac <---> AudioFormat.AAC
//        // AudioFormat is optional, if given value, will overwrite path extension when there is conflicts.
//        _recorder =
//            FlutterAudioRecorder(audioPath, audioFormat: AudioFormat.AAC);
////        print(_recorder.recording.status);
//        _recorder.initialized.then((value) => print('intialized!!!!>><><><><>'));
//        // after initialization
////        var current = await _recorder.current(channel: 0);
////        print(current);
//        // should be "Initialized", if all working fine
////        setState(() {
////          _current = current;
////          _currentStatus = current.status;
////          print(_currentStatus);
////        });
////      } else {
////        Scaffold.of(context).showSnackBar(
////            new SnackBar(content: new Text("You must accept permissions")));
////      }
////    } catch (e) {
////      print('aUDIo ErrOR!! $e');
////    }
//    setState(() {
//    });
//  }

//  _startAudio() async {
//    print('audio STARTED');
//    await _recorder.start();
//    var recording = await _recorder.current(channel: 0);
//    print('RECORDING AUDIO STARTED : :: : : ${recording.path}');
//    try {
//      await _recorder.start();
//      var recording = await _recorder.current(channel: 0);
//      print(recording.path);
////      var recording = await _recorder.current(channel: 0);
////      setState(() {
////        _current = recording;
////      });
//
////      const tick = const Duration(milliseconds: 50);
////      new Timer.periodic(tick, (Timer t) async {
////        if (_currentStatus == RecordingStatus.Stopped) {
////          t.cancel();
////        }
////
////        var current = await _recorder.current(channel: 0);
//        // print(current.status);
////        setState(() {
////          _current = current;
////          _currentStatus = _current.status;
////        });
////      });
//    } catch (e) {
//      print(e);
//    }
//    setState(() {
//    });
//  }

//  _stopAudio() async {
//    var result = await _recorder.stop();
////    File file = localFileSystem.file(result.path);
////    var result = await _recorder.stop();
////    File file = localFileSystem.file(result.path);
//    print('AUDIO Stopped');
//    print("Stop recording: ${result.path}");
//    print("Stop recording: ${result.duration}");
//    print('AUDIO RECORDED PATH${result.path}');
//    setState(() {
//    });
////    File file = widget.localFileSystem.file(result.path);
////    print("File length: ${await file.length()}");
////    setState(() {
////      _current = result;
////      _currentStatus = _current.status;
////    });
//  }

}
