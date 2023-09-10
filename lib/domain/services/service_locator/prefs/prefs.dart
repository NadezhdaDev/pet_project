import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> registerSharedPrefs() async {
  SharedPreferences sharedPref = await SharedPreferences.getInstance();
  GetIt.instance.registerSingleton<SharedPreferences>(sharedPref);
}
