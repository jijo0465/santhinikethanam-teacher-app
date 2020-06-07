import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teacher_app/components/digi_appbar.dart';
import 'package:teacher_app/components/digi_drawer.dart';
import 'package:teacher_app/components/digi_menu_card.dart';
import 'package:teacher_app/components/digi_period_card.dart';
import 'package:teacher_app/screens/login_screen.dart';
import 'package:teacher_app/states/login_state.dart';
import 'package:teacher_app/screens/dashboard.dart';

class HomeScreen extends DrawerContent {
  HomeScreen({Key key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

HiddenDrawerController drawerController;

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    drawerController = HiddenDrawerController(
      initialPage: HomePage(
        title: 'Santhinikethanam',
        onPressed: (){drawerController.open();},
      ),
      items: [
        DrawerItem(
          text: Text('Home', style: TextStyle(color: Colors.white)),
          icon: Icon(Icons.home, color: Colors.white),
          onPressed: (){
            drawerController.close();
          },
        ),
        DrawerItem(
          text: Text(
            'SETTINGS',
            style: TextStyle(color: Colors.grey, fontFamily: "Poppins"),
          ),
          icon: Icon(Icons.settings, color: Colors.grey),
//          onPressed: () async {
////            await Navigator.of(context).pushNamed('/settings');
//            drawerController.close();
//          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginState>(
      builder: (BuildContext context, LoginState value, Widget child) {
        if (value.status == Status.Unauthenticated) {
          return LoginScreen();
        } else {
          return Scaffold(
            body: HiddenDrawer(
              controller: drawerController,
              header: Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 66,
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: MediaQuery.of(context).size.width * 0.5,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage(
                                    'assets/images/sir.jpg',
                                  ),
                                ),
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              'Hi Teacher',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            RaisedButton(
                                child: Text('Signout'),
                                onPressed: () {
                                  value.signOut();
                                })
                          ],
                        ),
                      ),
                    ),
                    Expanded(flex: 34, child: Container())
                  ],
                ),
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.blue[300], Colors.blue[800], Colors.blue],
                  // tileMode: TileMode.repeated,
                ),
              ),
            ),
            // bottomNavigationBar: BottomNavigationBar(
            //     selectedItemColor: Theme.of(context).primaryColor,
            //     unselectedItemColor: Colors.grey,
            //     onTap: (index) {
            //       if (index == 1) Navigator.of(context).pushNamed('/chat');
            //       else if(index==2) Navigator.of(context).pushNamed('/knowledge_base');
            //     },
            //     items: [
            //       BottomNavigationBarItem(
            //         icon: Icon(Icons.home,),
            //         title: Text('Home'),
            //       ),
            //       BottomNavigationBarItem(
            //           icon: Icon(Icons.message), title: Text('Chat')),
            //       BottomNavigationBarItem(
            //         icon: Icon(Icons.video_label),
            //         title: Text('Teach me'),
            //       ),
            //     ]),
          );
        }
      },
    );
  }
}

// class HomePage extends DrawerContent {
//   HomePage({this.onPressed, Key key, this.title});
//   final String title;
//   final VoidCallback onPressed;
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   PageController _pageController;
//   @override
//   void initState() {
//     _pageController = PageController(initialPage: 0, viewportFraction: 0.92);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Stack(
//         children: <Widget>[
//           Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               SizedBox(height: MediaQuery.of(context).padding.top + 60,),
//               DigiAppbar(
//                 onPressed: () {
//                   drawerController.open();
//                 },
//               ),
//               Expanded(
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: <Widget>[
//                       SizedBox(height: 30),
//                        DigiMenuCard(
//                         height: MediaQuery.of(context).size.height * 0.17,
//                         width: MediaQuery.of(context).size.width * 0.91,
//                         onPressed: () {
//                           Navigator.of(context)
//                               .pushNamed('/classroom_screen');
//                         },
//                         imagePath: 'assets/images/classroom.png',
//                       ),
//                       SizedBox(height:5),
//                       Row(
//                         children: <Widget>[
//                           SizedBox(
//                             width: 15,
//                           ),
//                           Expanded(
//                             flex: 1,
//                             child: Container(
//                               child: DigiMenuCard(
//                                 height:
//                                     MediaQuery.of(context).size.height * 0.3,
//                                 onPressed: () {
//                                   Navigator.of(context)
//                                       .pushNamed('/attendance');
//                                 },
//                                 imagePath: 'assets/images/check_attendance.png',
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             width: 15,
//                           ),
//                           Expanded(
//                             flex: 1,
//                             child: Column(
//                               children: <Widget>[
//                                 Container(
//                                   child: DigiMenuCard(
//                                     height: MediaQuery.of(context).size.height *
//                                         0.15,
//                                     onPressed: () {
//                                       Navigator.of(context)
//                                           .pushNamed('/track_bus');
//                                     },
//                                     imagePath:
//                                         'assets/images/track_schoolbus.png',
//                                   ),
//                                 ),
//                                 SizedBox(height:5),
//                                 DigiMenuCard(
//                                   height:
//                                       MediaQuery.of(context).size.height * 0.15,
//                                   onPressed: () {
//                                     Navigator.of(context).pushNamed('/rewards');
//                                   },
//                                   imagePath: 'assets/images/give_rewards.png',
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(
//                             width: 15,
//                           )
//                         ],
//                       ),
//                       SizedBox(height: 5),
//                       Row(
//                         children: <Widget>[
//                           SizedBox(
//                             width: 15,
//                           ),
//                           Expanded(
//                             flex: 1,
//                             child: Column(
//                               children: <Widget>[
//                                 Container(
//                                   child: DigiMenuCard(
//                                     height: MediaQuery.of(context).size.height*
//                                         0.15,
//                                     onPressed: () {
//                                       Navigator.of(context)
//                                           .pushNamed('/contact_parents');
//                                     },
//                                     imagePath:
//                                         'assets/images/contact_parents.png',
//                                   ),
//                                 ),
//                                 SizedBox(height:5),
//                                 DigiMenuCard(
//                                   height:
//                                       MediaQuery.of(context).size.height*0.3,
//                                   onPressed: () {
//                                     Navigator.of(context)
//                                         .pushNamed('/upcoming_exams');
//                                   },
//                                   imagePath: 'assets/images/upcoming_exams.png',
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(
//                             width: 15,
//                           ),
//                           Expanded(
//                             flex: 1,
//                             child: Column(
//                               children: <Widget>[
//                                 Container(
//                                   child: DigiMenuCard(
//                                     height: MediaQuery.of(context).size.height *
//                                         0.3,
//                                     onPressed: () {
//                                       Navigator.of(context)
//                                           .pushNamed('/remarks');
//                                     },
//                                     imagePath:
//                                         'assets/images/write_remarks.png',
//                                   ),
//                                 ),
//                                 SizedBox(height:5),
//                                 DigiMenuCard(
//                                   height:
//                                       MediaQuery.of(context).size.height * 0.15,
//                                   onPressed: () {
//                                     Navigator.of(context)
//                                         .pushNamed('/update_from_parents');
//                                   },
//                                   imagePath: 'assets/images/premark.png',
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(
//                             width: 15,
//                           )
//                         ],
//                       ),
//                       SizedBox(height: 5),
//                       DigiMenuCard(
//                         height: MediaQuery.of(context).size.height * 0.13,
//                         width: MediaQuery.of(context).size.width * 0.91,
//                         onPressed: () {
//                           Navigator.of(context)
//                               .pushNamed('/update_student_profile');
//                         },
//                         imagePath: 'assets/images/student_profile.png',
//                       ),
//                       SizedBox(height: 5),
//                       Row(
//                         children: <Widget>[
//                           SizedBox(width: 15),
//                           Expanded(
//                             flex: 1,
//                             child: DigiMenuCard(
//                               height: MediaQuery.of(context).size.height * 0.3,
//                               onPressed: () {
//                                 Navigator.of(context)
//                                     .pushNamed('/update_homework');
//                               },
//                               imagePath: 'assets/images/update_homework.png',
//                             ),
//                           ),
//                           SizedBox(width: 15),
//                           Expanded(
//                             flex: 1,
//                             child: Column(
//                               children: <Widget>[
//                                 DigiMenuCard(
//                                   height:
//                                       MediaQuery.of(context).size.height * 0.15,
//                                   onPressed: () {
//                                     Navigator.of(context)
//                                         .pushNamed('/update_test_paper');
//                                   },
//                                   imagePath:
//                                       'assets/images/update_testpaper.png',
//                                 ),
//                                 SizedBox(height:5),
//                                 DigiMenuCard(
//                                   height:
//                                       MediaQuery.of(context).size.height * 0.15,
//                                   onPressed: () {
//                                     Navigator.of(context)
//                                         .pushNamed('/approve_leave_request');
//                                   },
//                                   imagePath: 'assets/images/approve_leave.png',
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(width: 15)
//                         ],
//                       ),
//                       SizedBox(height: 5),
//                       Row(
//                         children: <Widget>[
//                           SizedBox(width: 15,),
//                           Column(
//                             children: <Widget>[
//                               DigiMenuCard(
//                                 height: MediaQuery.of(context).size.height * 0.15,
//                                 width: MediaQuery.of(context).size.width*0.44,
//                                 onPressed: () {
//                                   Navigator.of(context).pushNamed('/leave_request');
//                                 },
//                                 imagePath: 'assets/images/leave_request.png',
//                               ),
//                               SizedBox(height: 5),
//                                DigiMenuCard(
//                             height: MediaQuery.of(context).size.height * 0.15,
//                              width: MediaQuery.of(context).size.width*0.44,
//                             onPressed: () {
//                               Navigator.of(context).pushNamed('/student_360');
//                             },
//                             imagePath: 'assets/images/360.png',
//                           ),
//                             ],
//                           ),
//                          SizedBox(width: 15,),
//                          DigiMenuCard(
//                                   height:
//                                       MediaQuery.of(context).size.height*0.3,
//                                       width: MediaQuery.of(context).size.width*0.43,
//                                   onPressed: () {
//                                     Navigator.of(context)
//                                         .pushNamed('/student_result');
//                                   },
//                                   imagePath: 'assets/images/report.png',
//                                 ),
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//               )

//             ],
//           ),
//           Positioned(top: 140, child: DigiPeriodCard()),
//         ],
//       ),
//     );
//   }
// }
