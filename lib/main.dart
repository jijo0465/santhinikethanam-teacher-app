import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teacher_app/redirect.dart';
import 'package:teacher_app/screens/approve_leave_request.dart';
import 'package:teacher_app/screens/attendance_history.dart';
import 'package:teacher_app/screens/attendance_screen.dart';
import 'package:teacher_app/screens/bus_tracking_screen.dart';
import 'package:teacher_app/screens/chat_screen.dart';
import 'package:teacher_app/screens/call.dart';
import 'package:teacher_app/screens/classroom_screen.dart';
import 'package:teacher_app/screens/contact_parent_screen.dart';
import 'package:teacher_app/screens/discussions_screen.dart';
import 'package:teacher_app/screens/forgot_password_screen.dart';
import 'package:teacher_app/screens/home_screen.dart';
import 'package:teacher_app/screens/knowledge_base.dart';
import 'package:teacher_app/screens/leave_request_screen.dart';
import 'package:teacher_app/screens/live_screen.dart';
import 'package:teacher_app/screens/new_password_screen.dart';
import 'package:teacher_app/screens/remark_screen.dart';
import 'package:teacher_app/screens/reward_screen.dart';
import 'package:teacher_app/screens/settings_screen.dart';
import 'package:teacher_app/screens/student_360.dart';
import 'package:teacher_app/screens/student_result.dart';
import 'package:teacher_app/screens/teacher_profile_screen.dart';
import 'package:teacher_app/screens/update_homework.dart';
import 'package:teacher_app/screens/update_test_paper.dart';
import 'package:teacher_app/states/login_state.dart';
import 'package:teacher_app/states/user_state.dart';
import 'package:teacher_app/screens/upcoming_exam_screen.dart';
import 'package:teacher_app/screens/update_student_profile.dart';
import 'package:teacher_app/screens/update_from_parents.dart';
import 'package:teacher_app/states/teacher_state.dart';

void main() => runApp(TeacherApp());

class TeacherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<LoginState>(
              create: (_) => LoginState.instance()),
          ChangeNotifierProvider<TeacherState>(
              create: (_) => TeacherState.instance()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primaryColor: Color(0xff00739e),
              accentColor: Colors.deepOrange,
              fontFamily: 'Poppins'),
          supportedLocales: const [Locale('en')],
          localizationsDelegates: [
            DefaultMaterialLocalizations.delegate,
            DefaultWidgetsLocalizations.delegate,
          ],
          home: Redirect(),
          routes: <String, WidgetBuilder>{
//            '/home': (context) => HomeScreen(),
//            '/settings': (context) => SettingsScreen(),
//            '/attendance': (context) => AttendanceScreen(),
//            '/track_bus': (context) => BusTrackingScreen(),
//            '/contact_parents': (context) => ContactParentScreen(),
//            '/rewards': (context) => RewardScreen(),
//            '/remarks': (context) => RemarkScreen(),
//            '/upcoming_exams': (context) => UpcomingExams(),
//            '/update_student_profile': (context) => UpdateStudentProfile(),
//            '/update_from_parents': (context) => UpdateFromParents(),
//            '/teacher_profile': (context) => TeacherProfileScreen(),
//            '/forgot_password': (context) => ForgotPasswordScreen(),
//            '/new_password': (context) => NewPasswordScreen(),
//            '/update_test_paper': (context) => UpdateTestPaper(),
//            '/update_homework': (context) => UpdateHomework(),
//            '/leave_request': (context) => LeaveRequest(),
//            '/approve_leave_request': (context) => ApproveLeaveRequest(),
//            '/attendance_history':(context) => AttendanceHistory(),
            '/classroom_screen': (context) => ClassroomScreen(),
            '/discussions': (context) => DiscussionsScreen(),
            '/live': (context) => LiveScreen(),
//            '/chat': (context) => ChatScreen(),
//            '/student_360': (context) => Student360Screen(),
//            '/student_result':(context) => StudentResult(),
//            '/knowledge_base':(context) => KnowledgeBase(),
//            '/call':(context) => CallPage(),
          },
        ));
  }
}
