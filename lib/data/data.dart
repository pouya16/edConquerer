import 'package:shared_preferences/shared_preferences.dart';

class AppData {

  static saveToken(String data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', data);
  }

  static getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String data = prefs.getString('token') ?? '';
    return data;
  }

  static saveName(String data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', data);
  }

  static getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String data = prefs.getString('name') ?? 'Guest';
    return data;
  }

}