import 'package:flutter/material.dart';
import 'package:pet_lib/data_tutorial.dart';

import '../../data/prefs/pp_prefs.dart';
import '../../domain/services/translation/app_translations.dart';
import '../../domain/services/translation/translation.dart';
import '../../internal/modules/remoteconfig/remote_config_module.dart';
import '../constants/pp_color.dart';
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
      backgroundColor: PPColor.splashScreenBackgroundColor,
      body: Center(
          child: Text(
        'HELLO',
        style: TextStyle(fontFamily: 'Destroy', fontSize: 30),
      )),
    );
  }

  void init(BuildContext context) async {
    await AppTranslations().loadJsonLocale(context);

    if (PPPrefs().isFirstLaunch()) {
      await PPPrefs().setFirstLaunch(false);
      await PPPrefs().setLocale(PPPrefs().getLocale() ?? const Locale('en'));
      RemoteConfigModule.get().isShowTutorial()
          ? navigate(
              PPRoutePath.tutorial,
              argument: DataTutorial(
                startPageTitle: Translator().tutorialStartPageTitle,
                startPageSubtitle: Translator().tutorialStartPageSubtitle,
                videoPageTitle: Translator().tutorialVideoPageTitle,
                endPageTitle: Translator().tutorialEndPageTitle,
                nextButtonLabel: Translator().next,
                finishTutorialFunction: () => _routeToHome(),
              ),
              replace: true,
            )
          : _routeToHome();
    } else {
      _routeToHome();
    }
  }

  void _routeToHome() => navigate(
        PPRoutePath.home,
        replace: true,
      );
}
