import 'package:shared_preferences/shared_preferences.dart';

class SavedPreferenceModel{

  static SavedPreferenceModel _instance;

  static SavedPreferenceModel get instance{
    if(_instance == null){
      _instance = new SavedPreferenceModel();
    }
    return _instance;
  }

  void setUserId(int userId)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("userId", userId);
  }

  void setUserName(String username)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("userName", username);
  }
  void setFullName(String fullName)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("fullName", fullName);

  }
  void setUserAccount(String userAccount)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("userAccount", userAccount);
  }

  Future<int> getUserId()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt("userId");
  }

  Future<String> getFullName()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("fullName");
  }

  Future<String> getUserAccount()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("userAccount");
  }

  Future<String> getUserName()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("userName");
  }


}