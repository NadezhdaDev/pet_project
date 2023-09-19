import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_project/domain/services/translation/translation.dart';
import 'package:pet_project/presentation/state/locale/locale_cubit.dart';
import 'package:pet_project/presentation/state/locale/locale_state.dart';

import '../../domain/model/project.dart';
import '../constants/pp_color.dart';
import '../state/project/project_cubit.dart';
import '../state/project/project_state.dart';
import 'create_project_screen.dart';
import 'history_projects_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProjectCubit>(
      create: (contextCubit) => ProjectCubit(Project(
        uuid: 'Default Uuid',
      )),
      child: BlocBuilder<ProjectCubit, ProjectState>(
          builder: (contextCubit, state) {
        return BlocBuilder<LocaleCubit, LocaleState>(
          builder: (contextLocaleCubit, state) {
            return Scaffold(
              body: Center(
                child: <Widget>[
                  CreateProjectScreen(
                    projectCubit: contextCubit.read<ProjectCubit>(),
                  ),
                  HistoryProjectsScreen(
                    projectCubit: contextCubit.read<ProjectCubit>(),
                  ),
                ].elementAt(_selectedIndex),
              ),
              bottomNavigationBar: BottomNavigationBar(
                selectedLabelStyle:
                    const TextStyle(fontFamily: "Destroy", fontSize: 20.0),
                unselectedLabelStyle:
                    const TextStyle(fontFamily: "Destroy", fontSize: 18.0),
                elevation: 6.0,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.home),
                    label: Translator().newProject,
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.business),
                    label: Translator().allProjects,
                  ),
                ],
                currentIndex: _selectedIndex,
                selectedItemColor: PPColor.buttonPink,
                onTap: _onItemTapped,
              ),
            );
          }
        );
      }),
    );
  }
}
