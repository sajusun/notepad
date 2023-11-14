
import 'package:shared_preferences/shared_preferences.dart';
// Obtain shared preferences.

class SharedPref{
  Future<SharedPreferences> sharedPref= SharedPreferences.getInstance();
  static late SharedPreferences _store;

  // login varialbles
  static String _loginKey="islogin";
//class init
  SharedPref(){
    init();
  }
  init() async {
   _store= await sharedPref;
  }

 //set data with key
  static setData(String key,String value)  {
    _store.setString(key, value);
  }

   static getData(String key) {
       print(_store.get(key).toString());
  }
  static loginStatus(bool value) {
       _store.setBool(_loginKey, value);
  }
   static bool isLogined(){
    return _store.getBool(_loginKey)??false;
  }


}

