import 'package:flutter/material.dart';
import 'package:teacher_app/components/digi_chat.dart';
import 'package:teacher_app/models/student.dart';
import 'package:teacher_app/states/teacher_state.dart';
import 'package:provider/provider.dart';
import 'package:teacher_app/components/digicampus_appbar.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int _teacherId = Provider.of<TeacherState>(context).teacher.id;
    List<Student> student = [
      Student(
          id:2001,
          name: "Arya\nPid",
          photoUrl: "assets/images/1001.jpg"
          ),
      Student(
          id: 2002,
          name: "Arjun\nPid",
          photoUrl: "assets/images/sir.jpg"
          ),
      Student(
          id: 2003,
          name: "Bran\nPid",
          photoUrl: "assets/images/1001.jpg"),
    ];
    return Container(
        // bottomNavigationBar: BottomNavigationBar(
        //     selectedItemColor: Theme.of(context).primaryColor,
        //     unselectedItemColor: Colors.grey,
        //     currentIndex: 1,
        //     onTap: (index) {
        //       if (index == 0) Navigator.of(context).pop();
        //     },
        //     items: [
        //       BottomNavigationBarItem(
        //           icon: Icon(Icons.home), title: Text('Home')),
        //       BottomNavigationBarItem(
        //           icon: Icon(Icons.message), title: Text('Chat')),
        //       BottomNavigationBarItem(
        //         icon: Icon(Icons.info),
        //         title: Text('About'),
        //       ),
        //     ]),
        child: Column(
          children: <Widget>[
            // DigiCampusAppbar(),
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      // print(teachers.elementAt(index).name);
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return DigiChat(
                            student: student.elementAt(index),
                            teacherId: _teacherId);
                      }));
                    },
                    child: Card(
                      child: Container(
                        height: 80,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: <Widget>[
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: AssetImage(
                                        student.elementAt(index).photoUrl),
                                    fit: BoxFit.fill),
                              ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Container(
                              child: Text(student.elementAt(index).name),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ));
  }
}
