import 'package:flutter/material.dart';

import '../../data/prefs/pp_prefs.dart';
import '../../domain/services/translation/app_translations.dart';
import '../navigation/navigation.dart';
import '../navigation/pp_route_path.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    init(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
          child: Text(
            'HELLO',
            style: TextStyle(fontFamily: 'Destroy', fontSize: 30),
          )),
    );
  }


  void init(BuildContext context) async{
    await AppTranslations().loadJsonLocale(context);

    if(PPPrefs().isFirstLaunch()){
      await PPPrefs().setFirstLaunch(false);
      await PPPrefs().setLocale(PPPrefs().getLocale()??const Locale('en'));
    }

    navigate(
      PPRoutePath.home,
      replace: true,
    );

  }
}
