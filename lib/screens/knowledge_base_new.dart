import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:teacher_app/models/playlist.dart';
import 'package:teacher_app/models/video.dart';
import 'package:teacher_app/services/knowledge_youtube_service.dart';

class KnowledgeBase extends StatefulWidget {
  @override
  _KnowledgeBaseState createState() => _KnowledgeBaseState();
}

class _KnowledgeBaseState extends State<KnowledgeBase> {
  List<Map<String, dynamic>> _allPlaylist = [{}];
  Playlist _playlist;
  bool _isLoading = false;
  bool val = false;
  int grade = 8;
  int chapterIndex = 0;
  int videoCountFlag = 0;
  int playlistFlag = 1;
  String _playlistId;
  Firestore firestore = Firestore.instance;
  DocumentSnapshot subjectPlaylist;

  @override
  void initState() {
    super.initState();
    _getPlaylistData();
  }

  _getPlaylistData() {
    firestore
        .collection("class_$grade").document("subject_1").get().then((DocumentSnapshot value) {
//          print(value['chapters']);
          subjectPlaylist = value;
//          print(subjectPlaylist['chapters'].length);
          for(int i=0; i<subjectPlaylist['chapters'].length; i++)
            {
              _allPlaylist.insert(i, subjectPlaylist['chapters'][i]);
              print(_allPlaylist[i]);
            }
//          setState((){
            _playlistId = subjectPlaylist['chapters'][0]['playlist'];
//          });
          _initPlaylist(_playlistId,_allPlaylist[playlistFlag-1]['name'].toString(),playlistFlag-1);
    });
  }

  _initPlaylist(String playlistId,String playlistName,int playlistIndex) async {
    Playlist playlist = await APIService.instance
        .fetchPlaylist(playlistId: playlistId);
    playlist.videos.forEach((element) {
      element.setChannelTitle(playlistName);
      element.setIndex(playlistIndex);
    });
    videoCountFlag = int.parse(playlist.videoCount);
    print(videoCountFlag);
    setState(() {
      _playlist = playlist;
    });
  }

//  _buildProfileInfo() {
//    return Container(
//      margin: EdgeInsets.all(20.0),
//      padding: EdgeInsets.all(20.0),
//      height: 100.0,
//      decoration: BoxDecoration(
//        color: Colors.white,
//        boxShadow: [
//          BoxShadow(
//            color: Colors.black12,
//            offset: Offset(0, 1),
//            blurRadius: 6.0,
//          ),
//        ],
//      ),
//      child: Row(
//        children: <Widget>[
//          CircleAvatar(
//            backgroundColor: Colors.white,
//            radius: 35.0,
//            backgroundImage: NetworkImage('https://www.w3schools.com/w3css/img_lights.jpg'),
//          ),
//          SizedBox(width: 12.0),
//          Expanded(
//            child: Column(
//              mainAxisAlignment: MainAxisAlignment.center,
//              crossAxisAlignment: CrossAxisAlignment.start,
//              children: <Widget>[
//                Text(
//                  _channel.title,
//                  style: TextStyle(
//                    color: Colors.black,
//                    fontSize: 20.0,
//                    fontWeight: FontWeight.w600,
//                  ),
//                  overflow: TextOverflow.ellipsis,
//                ),
//                Text(
//                  '${_channel.subscriberCount} subscribers',
//                  style: TextStyle(
//                    color: Colors.grey[600],
//                    fontSize: 16.0,
//                    fontWeight: FontWeight.w600,
//                  ),
//                  overflow: TextOverflow.ellipsis,
//                ),
//              ],
//            ),
//          )
//        ],
//      ),
//    );
//  }

  _buildVideo(Video video,int playlistIndex) {

    return GestureDetector(
      onTap: () {
        print(video.id);
        firestore.collection('class_$grade').document('student_subject_1').updateData(
            {'chapter_${video.channelIndex}' : FieldValue.arrayUnion(
                [{'name': video.title, 'videoId': video.id,   'chapterName': video.channelTitle}])
              });
      },
//      => Navigator.push(
//        context,
//        MaterialPageRoute(
//          builder: (_) => VideoScreen(id: video.id),
//        ),
//      ),
      child: Container(
//        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
        padding: EdgeInsets.all(10.0),
        height: 140.0,
        decoration: BoxDecoration(
          color: Colors.white70,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 1),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: 150.0,
              child: Stack(
                children: <Widget>[
                  Image(
                    width: 150.0,
                    image: NetworkImage(video.thumbnailUrl),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Icon(Icons.play_arrow,color: Theme.of(context).primaryColor.withOpacity(0.7),size: 80),
                  )
                ],
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: Text(
                      video.channelTitle,
                      style: TextStyle(fontWeight: FontWeight.w700)),
                  ),
                  Flexible(
                    flex: 3,
                    child: Text(
                      video.title,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: RaisedButton(
                          child: Text('Share'),
                          elevation: 8,
                          color: Theme.of(context).primaryColor.withOpacity(0.7),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          onPressed: (){}),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _loadMoreVideos(String playlistId, String playlistName, int playlistIndex) async {
    _isLoading = true;
    List<Video> moreVideos = await APIService.instance
        .fetchVideosFromPlaylist(playlistId: playlistId);
    moreVideos.forEach((element) {
      element.setChannelTitle(playlistName);
      element.setIndex(playlistIndex);
    });
    List<Video> allVideos = _playlist.videos..addAll(moreVideos);
    setState(() {
      _playlist.videos = allVideos;;
    });
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ClipPath(
          clipper: BackgroundClipper(),
          child: Container(
            color: Theme.of(context).primaryColor,
            height: 120 - MediaQuery.of(context).padding.top,
            width: double.infinity,
            child: Column(
              children: <Widget>[
              Expanded(
                child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 35,
                    decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)),
                     child: TextFormField(
                      decoration: InputDecoration(
                      hintText: "search",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(color: Colors.blue))))),
                  IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    onPressed: () {
//                          setState(() {
//                            val = !val;
//                          });
                    }),
                ])),
                SizedBox(height: 40)
            ])
          )),
        Container(
          height: 40,
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: <Widget>[
              Container(
                // height: double.infinity,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(color: Colors.grey, blurRadius: 4)
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12))),
                child: Text('Class',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold)),
                alignment: Alignment.center,
                // padding: EdgeInsets.only(left: 8),
                width: 100,
              ),
              VerticalDivider(
                width: 10,
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text('VI'),
                      Checkbox(
                          activeColor: Theme.of(context)
                              .primaryColor
                              .withOpacity(0.8),
                          value: grade==6 ?true :false,
                          onChanged: (value) {
                            setState(() {
                              grade = 6;
                            });
                          }),
                      SizedBox(width: 12),
                      Text('VII'),
                      Checkbox(
                          activeColor: Theme.of(context)
                              .primaryColor
                              .withOpacity(0.8),
                          value: grade==7 ?true :false,
                          onChanged: (value) {
                            setState(() {
                              grade = 7;
                            });
                          }),
                      SizedBox(width: 12),
                      Text('VIII'),
                      Checkbox(
                          activeColor: Theme.of(context)
                              .primaryColor
                              .withOpacity(0.8),
                          value: grade==8 ?true :false,
                          onChanged: (value) {
                            setState(() {
                              grade = 8;
                            });
                          }),
                      SizedBox(width: 12),
                      Text('IX'),
                      Checkbox(
                          activeColor: Theme.of(context)
                              .primaryColor
                              .withOpacity(0.8),
                          value: grade==9 ?true :false,
                          onChanged: (value) {
                            setState(() {
                              grade = 9;
                            });
                          }),
                      SizedBox(width: 12),
                      Text('X'),
                      Checkbox(
                        // checkColor: Theme.of(context).primaryColor,
                          activeColor: Theme.of(context)
                              .primaryColor
                              .withOpacity(0.8),
                          value: grade == 10 ?true :false ,
                          onChanged: (value) {
                            setState(() {
                              grade = 10;
                            });
                          }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
                child: _playlist != null
                    ? NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollDetails) {
                    if (!_isLoading &&
                        _playlist.videos.length != videoCountFlag && playlistFlag < _allPlaylist.length &&
                        scrollDetails.metrics.pixels ==
                            scrollDetails.metrics.maxScrollExtent) {
                      _loadMoreVideos(_playlistId, _allPlaylist[playlistFlag-1]['name'].toString(),playlistFlag-1);
                    }
                    if (!_isLoading &&
                        _playlist.videos.length == videoCountFlag && playlistFlag<_allPlaylist.length-1 &&
                        scrollDetails.metrics.pixels ==
                            scrollDetails.metrics.maxScrollExtent) {
//                          setState(() {
                        _playlistId = _allPlaylist[playlistFlag]['playlist'];
                        print(videoCountFlag);
//                          });
                      APIService.instance
                          .fetchPlaylist(playlistId: _playlistId).then((value) {
                        videoCountFlag += int.parse(value.videoCount);
                      });
                      print(playlistFlag);
//                          print(_playlist.videoCount);
                      _loadMoreVideos(_playlistId, _allPlaylist[playlistFlag]['name'].toString(),playlistFlag);
                      playlistFlag++;
                      print(playlistFlag);
                    }
                    return false;
                  },
                  child: ListView.builder(
//                        controller: ,
                    padding: EdgeInsets.all(0),
                    itemCount: _playlist.videos.length,
                    itemBuilder: (BuildContext context, int index) {
//                  if (index == 0) {
//                    return SizedBox(height: 0);
//                  }
                      Video video = _playlist.videos[index];
                      return _buildVideo(video,playlistFlag);
                    },
                  ),
                )
                    :Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor, // Red
                    ),
                  ),
                ),
              )
        ),
      ],
    );
  }
}

class BackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var roundnessFactor = 40.0;
    var path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height);
    path.quadraticBezierTo(0, size.height - roundnessFactor, roundnessFactor,
        size.height - roundnessFactor);
    path.lineTo(size.width - roundnessFactor, size.height - roundnessFactor);
    path.quadraticBezierTo(
        size.width, size.height - roundnessFactor, size.width, size.height);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}