import 'package:atm/model/saved_preference_model.dart';

class LoginModel{
 static LoginModel _instance;

 static LoginModel get instance{
   if(_instance == null){
     _instance = new LoginModel();
   }
   return _instance;
 }

 Future checkIfLoggedIn() async {
   if(SavedPreferenceModel.instance.getUserId == null)
     return false;
   else
     return true;

 }

}