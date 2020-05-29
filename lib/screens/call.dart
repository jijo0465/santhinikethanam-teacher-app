import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:teacher_app/components/digicampus_appbar.dart';
import 'package:teacher_app/components/live_stream_settings.dart';
import 'package:teacher_app/models/grade.dart';
import 'package:http/http.dart' as http;

class CallPage extends StatefulWidget {
  /// non-modifiable channel name of the page
  // final String channelName;

  /// Creates a call page with given channel name.
  const CallPage({Key key}) : super(key: key);

  @override
  _CallPageState createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
//  String TOKEN = '';
  static final _users = <int>[];
  final _infoStrings = <String>[];
  bool muted = false;
  final broadcasterUid = 3001;
  final bool isflag = false;
  bool checkParticipants = false;
  // Firestore firestore = Firestore.instance;
  // List<DocumentSnapshot> _items;
  // DocumentSnapshot _item;
  Grade grade = Grade.empty();
  int id = 4001;
  String resourceId;
  String sid;
  @override
  void dispose() {
    // clear users
    _users.clear();
    // destroy sdk
    AgoraRtcEngine.leaveChannel();
    AgoraRtcEngine.destroy();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    grade.setId(id);
    // initialize agora sdk
    initialize();
  }

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
    // await AgoraRtcEngine.enableWebSdkInteroperability(true);
    // await AgoraRtcEngine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    // await AgoraRtcEngine.setClientRole(ClientRole.Broadcaster);
    // await AgoraRtcEngine.setParameters(
    //     '{\"che.video.lowBitRateStreamParameter\":{\"width\":320,\"height\":180,\"frameRate\":15,\"bitRate\":140}}');
    // await AgoraRtcEngine.joinChannel(null, widget.channelName, null, 0);
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
        'live',
        null,
        broadcasterUid);
        // startRecording();
    // await AgoraRtcEngine.enableWebSdkInteroperability(true);
  }

  /// Add agora event handlers
  void _addAgoraEventHandlers() {

//    AgoraRtcEngine.onRequestToken=(){
//      AgoraRtcEngine.renewToken(TOKEN);
//    };
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

    AgoraRtcEngine.onJoinChannelSuccess = (
      String channel,
      int uid,
      int elapsed,
    ) {
      
      
      setState(() {
        final info = 'onJoinChannel: $channel, uid: $uid';
        _infoStrings.add(info);
      });

      //   DocumentReference documentReference =
      //     firestore.collection('classroom_${grade.id}').document('live_session');
      // firestore.runTransaction((transaction) async {
      //   await transaction.update(
      //       documentReference, {'userid': FieldValue.arrayUnion([uid])});
      // });

      Future.delayed(Duration(seconds: 3)).then((value) {
        setState(() {
          _infoStrings.removeLast();
        });
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

    AgoraRtcEngine.onFirstRemoteVideoFrame = (
      int uid,
      int width,
      int height,
      int elapsed,
    ) {
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
    //  AgoraRtcEngine.createNativeView((viewId) {
    //   // _viewId = viewId;
    //   // print(widget.uid);
    //   // AgoraRtcEngine.setupLocalVideo(_viewId, VideoRenderMode.Fit);
    //   // AgoraRtcEngine.startPreview();
    //   AgoraRtcEngine.setupRemoteVideo(viewId, VideoRenderMode.Fit, broadcasterUid); //widget.uid  --> Broadcaster Uid
    //   // AgoraRtcEngine.startPreview();
    //   // AgoraRtcEngine.joinChannel(null, 'flutter', null, 0);
    // });
    // return AgoraRenderWidget(broadcasterUid, local: true, preview: true);
  }

  /// Toolbar layout
  Widget _toolbar() {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Flexible(
            flex: 2,
            child: RaisedButton(
                shape: CircleBorder(side: BorderSide(color: Colors.black12)),
                color: Theme.of(context).primaryColor.withOpacity(0.4),
                onPressed: checkParticipants ? null : () {},
                child: Icon(
                  Icons.chat,
                  color: Colors.white,
                  size: 20.0,
                )),
          ),
          Flexible(
            flex: 2,
            child: RaisedButton(
                shape: CircleBorder(side: BorderSide(color: Colors.black12)),
                color: Theme.of(context).primaryColor.withOpacity(0.4),
                onPressed: checkParticipants ? null : _onToggleMute,
                child: Icon(
                  muted ? Icons.mic_off : Icons.mic,
                  color: muted ? Colors.red : Colors.white,
                  size: 20,
                )),
          ),
          Flexible(
            flex: 3,
            child: RaisedButton(
              shape: CircleBorder(side: BorderSide(color: Colors.black12)),
              color: Theme.of(context).primaryColor.withOpacity(0.4),
              onPressed: checkParticipants ? null : () => _onCallEnd(context),
              child: Icon(
                Icons.call_end,
                color: Colors.red,
                size: 40.0,
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: RaisedButton(
                shape: CircleBorder(side: BorderSide(color: Colors.black12)),
                color: Theme.of(context).primaryColor.withOpacity(0.4),
                onPressed: checkParticipants ? null : _onSwitchCamera,
                child: Icon(
                  Icons.switch_camera,
                  color: Colors.white,
                  size: 20.0,
                )),
          ),
          Flexible(
            flex: 2,
            child: RaisedButton(
                shape: CircleBorder(side: BorderSide(color: Colors.black12)),
                color: Theme.of(context).primaryColor.withOpacity(0.4),
                onPressed: () {
                  setState(() {
                    checkParticipants = !checkParticipants;
                  });
                },
                child: Icon(
                  Icons.group,
                  color: Colors.white,
                  size: 20.0,
                )),
          ),
          //   RawMaterialButton(
          //     onPressed: _onToggleMute,
          //     child: Icon(
          //       muted ? Icons.mic_off : Icons.mic,
          //       color: muted ? Colors.white : Colors.blueAccent,
          //       size: 20.0,
          //     ),
          //     shape: CircleBorder(),
          //     elevation: 2.0,
          //     fillColor: muted ? Colors.blueAccent : Colors.white,
          //     padding: const EdgeInsets.all(12.0),
          //   ),
          //   RawMaterialButton(
          //     onPressed: () => _onCallEnd(context),
          //     child: Icon(
          //       Icons.call_end,
          //       color: Colors.white,
          //       size: 35.0,
          //     ),
          //     shape: CircleBorder(),
          //     elevation: 2.0,
          //     fillColor: Colors.redAccent,
          //     padding: const EdgeInsets.all(15.0),
          //   ),
          //   RawMaterialButton(
          //     onPressed: _onSwitchCamera,
          //     child: Icon(
          //       Icons.switch_camera,
          //       color: Colors.blueAccent,
          //       size: 20.0,
          //     ),
          //     shape: CircleBorder(),
          //     elevation: 2.0,
          //     fillColor: Colors.white,
          //     padding: const EdgeInsets.all(12.0),
          //   )
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
                              Theme.of(context).primaryColor.withOpacity(0.3),
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
    // stopRecording();
    Navigator.pop(context);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(
          children: <Widget>[
            // _viewRows(),
            _viewVideo(),
            _panel(),
            _toolbar(),
            DigiCampusAppbar(
              icon: Icons.close,
              onDrawerTapped: () {
                Navigator.of(context).pop();
              },
            ),
            // StreamBuilder<QuerySnapshot>(
            // stream:
            //     firestore.collection('classroom_${grade.id}').snapshots(),
            // builder: (BuildContext context,
            //     AsyncSnapshot<QuerySnapshot> snapshot) {
            //   // if (!snapshot.hasData)
            //   if (!snapshot.hasData)
            //     return
            //   Center(
            //     child: CircularProgressIndicator(
            //       valueColor: AlwaysStoppedAnimation<Color>(
            //           Theme.of(context).primaryColor),
            //     ),
            //   );
            // else {
            //   _items = snapshot.data.documents;
            //   for (int i = 0; i < _items.length; i++)
            //     if (_items[i].documentID == 'live_session')
            //       _item = _items[i];
            //   return
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                        sigmaX: checkParticipants ? 25 : 0,
                        sigmaY: checkParticipants ? 25 : 0),
                    child: checkParticipants
                        ? Container(
                            width: MediaQuery.of(context).size.width - 40,
                            height: MediaQuery.of(context).size.height * 0.6,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.black
                                  .withOpacity(checkParticipants ? 0.4 : 0.0),
                            ),
                            child: _users.length == 0
                                ? Text('No Users Joined!',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16))
                                : Column(
                                    children:
                                        //   List.generate(
                                        //       _item['userid'].length, (index) {
                                        // return Text('User ${index+1} : ${_item['userid'][index]}',
                                        List.generate(_users.length, (index) {
                                    return Text(
                                        'User ${index + 1} : ${_users.elementAt(index)}',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16));
                                  }))
                            // Center(
                            //     child: Text(
                            //   'No Participants yet!',
                            //   style: TextStyle(
                            //       color: Colors.white, fontSize: 16),
                            // ))
                            // Container(
                            //     // width: 300,
                            //     // color: Colors.white.withOpacity(0.3),
                            //     ),
                            )
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
    );
  }

  Future<void> startRecording() async {
    print("Starting Recording");
    String url = 'http://192.168.0.12:8080/start_recording';
    Map<String, String> headers = {"Content-type": "application/json"};
    Map<String, dynamic> params = {};
    String data = jsonEncode(params);
    
    http.get(url, headers: headers).then((response) {
      // print(response.body);
      // resourceId = json.decode(response.body)['resourceId'];
      // sid = json.decode(response.body)['resourceId'];
    }).catchError((error) => print(error));
  }

  Future<void> stopRecording() async {
    print('Stopping Recording....');
    String url = 'http://192.168.0.12:8080/stop_recording';
    Map<String, String> headers = {"Content-type": "application/json"};
    Map<String, dynamic> params = {"resourceId": "$resourceId","sid":"$sid"};
    String data = jsonEncode(params);
    await http.get(url, headers: headers).then((response) {
      print(response.body);
      
    }).catchError((error) => print(error));
  }
}
