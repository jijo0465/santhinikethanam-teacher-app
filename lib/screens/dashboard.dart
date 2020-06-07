import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teacher_app/components/confirm_class.dart';
import 'package:teacher_app/components/digi_drawer.dart';
import 'package:teacher_app/components/page_header.dart';
import 'package:teacher_app/components/digi_appbar.dart';
import 'package:teacher_app/components/digi_menu_card.dart';
import 'package:teacher_app/components/digi_period_card.dart';
import 'package:teacher_app/components/digi_nav_bar.dart';
import 'package:teacher_app/screens/chat_screen.dart';
import 'package:teacher_app/screens/knowledge_base_new.dart';

class HomePage extends DrawerContent {
  const HomePage({this.onPressed, this.title, Key key}) : super(key: key);
  final String title;
  final VoidCallback onPressed;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool val = false;
  int navState = 0;
  PageController _pageController;
  @override
  void initState() {
    _pageController = PageController(initialPage: 0, keepPage: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          //   Stack(
          // children: <Widget>[
          Stack(
        children: [
          Column(
            children: <Widget>[
              // SizedBox(height: 60 + MediaQuery.of(context).padding.top),
              PageHeader(
                onPressed: widget.onPressed,
              ),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  children: <Widget>[
                    Container(
                      child: Stack(
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              DigiAppbar(
                                  // onPressed: () {
                                  //   drawerController.open();
                                  // },
                                  ),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(height: 30),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(18),
                                              child: DigiMenuCard(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.15,
                                                onPressed: () {
                                                  setState(() {
                                                    val = !val;
                                                  });
                                                },
                                                imagePath:
                                                    'assets/images/classroom.png',
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          Expanded(
                                            flex: 1,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(18),
                                              child: DigiMenuCard(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.15,
                                                onPressed: () {
                                                  Navigator.of(context).pushNamed(
                                                      '/classroom_screen');
                                                },
                                                imagePath:
                                                    'assets/images/virtual.png',
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: <Widget>[
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              child: DigiMenuCard(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.3,
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pushNamed('/attendance');
                                                },
                                                imagePath:
                                                    'assets/images/check_attendance.png',
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              children: <Widget>[
                                                Container(
                                                  child: DigiMenuCard(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.15,
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pushNamed(
                                                              '/track_bus');
                                                    },
                                                    imagePath:
                                                        'assets/images/track_schoolbus.png',
                                                  ),
                                                ),
                                                SizedBox(height: 5),
                                                DigiMenuCard(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.15,
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pushNamed('/rewards');
                                                  },
                                                  imagePath:
                                                      'assets/images/give_rewards.png',
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 15,
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: <Widget>[
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              children: <Widget>[
                                                Container(
                                                  child: DigiMenuCard(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.15,
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pushNamed(
                                                              '/contact_parents');
                                                    },
                                                    imagePath:
                                                        'assets/images/contact_parents.png',
                                                  ),
                                                ),
                                                SizedBox(height: 5),
                                                DigiMenuCard(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.3,
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pushNamed(
                                                            '/upcoming_exams');
                                                  },
                                                  imagePath:
                                                      'assets/images/upcoming_exams.png',
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              children: <Widget>[
                                                Container(
                                                  child: DigiMenuCard(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.3,
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pushNamed(
                                                              '/remarks');
                                                    },
                                                    imagePath:
                                                        'assets/images/write_remarks.png',
                                                  ),
                                                ),
                                                SizedBox(height: 5),
                                                DigiMenuCard(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.15,
                                                  onPressed: () {
                                                    Navigator.of(context).pushNamed(
                                                        '/update_from_parents');
                                                  },
                                                  imagePath:
                                                      'assets/images/premark.png',
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 15,
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      DigiMenuCard(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.13,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.91,
                                        onPressed: () {
                                          Navigator.of(context).pushNamed(
                                              '/update_student_profile');
                                        },
                                        imagePath:
                                            'assets/images/student_profile.png',
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: <Widget>[
                                          SizedBox(width: 15),
                                          Expanded(
                                            flex: 1,
                                            child: DigiMenuCard(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.3,
                                              onPressed: () {
                                                Navigator.of(context).pushNamed(
                                                    '/update_homework');
                                              },
                                              imagePath:
                                                  'assets/images/update_homework.png',
                                            ),
                                          ),
                                          SizedBox(width: 15),
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              children: <Widget>[
                                                DigiMenuCard(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.15,
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pushNamed(
                                                            '/update_test_paper');
                                                  },
                                                  imagePath:
                                                      'assets/images/update_testpaper.png',
                                                ),
                                                SizedBox(height: 5),
                                                DigiMenuCard(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.15,
                                                  onPressed: () {
                                                    Navigator.of(context).pushNamed(
                                                        '/approve_leave_request');
                                                  },
                                                  imagePath:
                                                      'assets/images/approve_leave.png',
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: 15)
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: <Widget>[
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Column(
                                            children: <Widget>[
                                              DigiMenuCard(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.15,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.44,
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pushNamed(
                                                          '/leave_request');
                                                },
                                                imagePath:
                                                    'assets/images/leave_request.png',
                                              ),
                                              SizedBox(height: 5),
                                              DigiMenuCard(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.15,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.44,
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pushNamed(
                                                          '/student_360');
                                                },
                                                imagePath:
                                                    'assets/images/360.png',
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          DigiMenuCard(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.3,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.43,
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pushNamed('/student_result');
                                            },
                                            imagePath:
                                                'assets/images/report.png',
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // SizedBox(height: 60)
                            ],
                          ),
                          Positioned(top: 60, child: DigiPeriodCard()),
                        ],
                      ),
                    ),
                    KnowledgeBase(),
                    ChatScreen()
                  ],
                ),
              ),
              DigiBottomNavBar(
                selected: navState,
                onChanged: (value) async {
                  await _pageController.animateToPage(value,
                      duration: Duration(milliseconds: 600),
                      curve: Curves.fastLinearToSlowEaseIn);
                  setState(() {
                    navState = value;
                  });
                },
              ),
            ],
          ),
          val == true?GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              setState(() {
                val = !val;
              });
            },
            child: Container(
              color: Colors.black.withOpacity(0.3),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
          ):Container(),
          val == true
              ? Align(alignment: Alignment.center, child: ConfirmClass())
              : Container()
        ],
      ),

      // PageHeader(
      //   onPressed: widget.onPressed,
      // ),
      //     Positioned(
      //         bottom: 4,
      //         child: DigiBottomNavBar(
      //           selected: navState,
      //           onChanged: (value) async {
      //             await _pageController.animateToPage(value,
      //                 duration: Duration(milliseconds: 400),
      //                 curve: Curves.linear);
      //             setState(() {
      //               navState = value;
      //             });
      //           },
      //         ))
      //   ],
      // )
    );
  }

  // void setSelectedStudent(Student student) async {
  //   selectedStudent = student;
  //   if (selectedStudent != null) {
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }
}
