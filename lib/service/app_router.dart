import 'package:flutter/material.dart';
import 'package:flutter_bloc_task_app/screens/counter_bloc_screen.dart';
import 'package:flutter_bloc_task_app/screens/counter_screen.dart';
import 'package:flutter_bloc_task_app/screens/covid_data_screen.dart';
import 'package:flutter_bloc_task_app/screens/cubit_to_cubit_communication.dart';
import 'package:flutter_bloc_task_app/screens/post_view_screen.dart';
import 'package:flutter_bloc_task_app/screens/recycle_bin.dart';
import 'package:flutter_bloc_task_app/screens/tab_screen.dart';
import 'package:flutter_bloc_task_app/screens/udemy_task_app.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => const TabScreen(),
        );
      case '/recycle_bin':
        return MaterialPageRoute(
          builder: (context) => const RecycleBin(),
        );
      case '/post_view':
        return MaterialPageRoute(
          builder: (context) => PostsView(),
        );
      case '/counter':
        return MaterialPageRoute(
          builder: (context) => const Counter(),
        );
      case '/counterBloc':
        return MaterialPageRoute(
          builder: (context) => const CounterBlocScreen(),
        );
      case '/CubitToCubit':
        return MaterialPageRoute(
          builder: (context) => const CubitToCubit(),
        );
      case '/TaskApp':
        return MaterialPageRoute(
          builder: (context) => const TaskApp(),
        );
      case '/CovidDataScreen':
        return MaterialPageRoute(
          builder: (context) => const CovidDataScreen(),
        );
      default:
        return null;
    }
  }
}
