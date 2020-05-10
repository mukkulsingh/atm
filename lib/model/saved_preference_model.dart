import 'package:shared_preferences/shared_preferences.dart';

class SavedPreferenceModel{

  static SavedPreferenceModel _instance;

  static SavedPreferenceModel get instance{
    if(_instance == null){
      _instance = new SavedPreferenceModel();
    }
    return _instance;
  }

  Future<int> getUserId()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt("userId");
  }
}