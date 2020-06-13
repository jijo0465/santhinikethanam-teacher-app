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
import 'package:teacher_app/states/teacher_state.dart';

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
                            Container(
                              child: Consumer<TeacherState>(
                                builder: (BuildContext context, TeacherState value,
                                    Widget child) {
                                  return Text(
                                    titleCase(value.teacher.name),
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 12,),
                            RaisedButton(
                                child: Text('Signout'),
                                onPressed: () {
                                  value.signOut();
                                }),
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
          );
        }
      },
    );
  }
  String titleCase(String text) {
    text = text.toLowerCase();
    if (text.length <= 1) return text.toUpperCase();
    var words = text.split(' ');
    var capitalized = words.map((word) {
      var first = word.substring(0, 1).toUpperCase();
      var rest = word.substring(1);
      return '$first$rest';
    });
    return capitalized.join(' ');
  }
}
