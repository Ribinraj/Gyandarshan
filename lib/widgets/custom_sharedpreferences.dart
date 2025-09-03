import 'package:shared_preferences/shared_preferences.dart';

Future<String> getUserToken() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getString('USER_TOKEN') ?? '';
}
Future<String> getdivisionId() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getString('DIVISION_ID') ?? '';
}
Future<String> gethomeTitle() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getString('HOME_TITLE') ?? '';
}