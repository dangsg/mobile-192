import 'package:shared_preferences/shared_preferences.dart';
class SharedPreferencesHelper{
  static final String _token = '';
  static Future<String> getToken() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_token)?? null;
  }
  static Future<void> setToken(String token)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_token, token);
  }

}