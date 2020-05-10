import 'package:shared_preferences/shared_preferences.dart';

class LogoutModel{

  static LogoutModel _instance;
  static LogoutModel get instance{
    if(_instance == null){
      _instance = new LogoutModel();
    }
    return _instance;
  }

  Future logout()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    return true;
  }

}