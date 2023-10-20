import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/prefs/pp_prefs.dart';
import '../../presentation/attributes/config/app_parameters.dart';
import '../../presentation/navigation/pp_route_path.dart';
import '../../presentation/navigation/pp_router.dart';
import '../../presentation/state/locale/locale_cubit.dart';
import '../../presentation/state/locale/locale_state.dart';

class Application extends StatefulWidget {
  const Application({
    Key? key,
  }) : super(key: key);

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  final PPRouter router = PPRouter();
  final Locale? locale = PPPrefs().getLocale();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LocaleCubit>(
          create: (_) => LocaleCubit(
              locale ?? const Locale('en')
          ),
        ),
      ],
      child: Builder(
        builder: (contextBloc) => BlocBuilder<LocaleCubit, LocaleState>(
            bloc: contextBloc.read<LocaleCubit>(),
            buildWhen: (previous, current) => current.locale != previous.locale,
            builder: (_, localeState) {
              return MaterialApp(
                builder: (context1, child) => MediaQuery(
                  data: MediaQuery.of(context1).copyWith(
                    textScaleFactor: 1.0,
                  ),
                  child: child ??
                      Container(
                        color: Colors.amber,
                      ),
                ),
                // locale
                locale: localeState.locale,
                navigatorKey: globalKey,
                initialRoute: PPRoutePath.splashScreen,
                onGenerateRoute: (routeSettings) => PPRouter.getAppRouteFactory(
                  contextBloc,
                  routeSettings,
                ),
                onGenerateInitialRoutes: (initialRoute) => [
                  PPRouter.getAppRouteFactory(
                    contextBloc,
                    RouteSettings(
                      name: initialRoute,
                      arguments: contextBloc,
                    ),
                  ),
                ],
              );
            }
        ),
      ),
    );
  }
}
