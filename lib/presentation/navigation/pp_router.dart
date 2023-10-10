

import 'package:flutter/material.dart';
import 'package:pet_lib/data_tutorial.dart';
import 'package:pet_lib/pet_lib.dart';
import 'package:pet_project/presentation/navigation/pp_route_path.dart';

import '../screens/edit_project_screen.dart';
import '../screens/home_screen.dart';
import '../screens/splash_screen.dart';
import '../state/project/project_cubit.dart';

class PPRouter {
  static Route getAppRouteFactory(
      BuildContext context, RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case PPRoutePath.splashScreen:
        return _routeSplashScreen();

      case PPRoutePath.home:
        return _routeHome();

      case PPRoutePath.editProjectScreen:
        return _routeEditProjectScreen(routeSettings.arguments as ProjectCubit);

      case PPRoutePath.tutorial:
        return _routeTutorial(routeSettings.arguments as DataTutorial);

      default:
        throw Exception(
          'Unsupported navigation route: ${routeSettings.name}!',
        );
    }
  }

  static Route _routeSplashScreen() => MaterialPageRoute(
        builder: (_) => const SplashScreen(),
      );

  static Route _routeHome() => MaterialPageRoute(
        builder: (_) => const HomeScreen(),
      );

  static Route _routeTutorial(DataTutorial dataTutorial) => MaterialPageRoute(
        builder: (_) => Tutorial(dataTutorial: dataTutorial).getTutorial(),
      );


  static Route _routeEditProjectScreen(ProjectCubit projectCubit) => MaterialPageRoute(
        builder: (_) => EditProjectScreen(
          projectCubit: projectCubit,
        ),
      );
}
