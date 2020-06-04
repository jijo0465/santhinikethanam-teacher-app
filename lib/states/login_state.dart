import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teacher_app/services/digi_auth.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }


class LoginState with ChangeNotifier {
  static Status _status = Status.Uninitialized;
  SharedPreferences _prfs;

  LoginState.instance();

  Status get status => _status;

  Future<bool> signIn(String teacherId, String password) async {
      DigiAuth digiAuth = DigiAuth();
      digiAuth.signIn(teacherId, password);
//    _status = Status.Authenticated;
//    notifyListeners();
//    _prfs = await SharedPreferences.getInstance();
//    _prfs.setBool('loggedIn',true);
    return true;
  }

  Future signOut() async {
    _status = Status.Unauthenticated;
    notifyListeners();
    _prfs = await SharedPreferences.getInstance();
    _prfs.setBool('loggedIn',false);  
  }
  Future<bool> setStatus(Status _statusUpdate) async {
    _status = _statusUpdate;
    notifyListeners();
    return true;
  }
}
