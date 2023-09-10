
import '../attributes/config/app_parameters.dart';

Future navigate(String screenName, {Object? argument, bool replace = false}) {
  return replace
      ? globalKey.currentState!.pushReplacementNamed(screenName, arguments: argument)
      : globalKey.currentState!.pushNamed(screenName, arguments: argument);
}