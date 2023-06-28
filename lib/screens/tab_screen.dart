

import 'package:flutter/material.dart';
import 'package:flutter_bloc_task_app/cubits/bottom_nav_cubit/bottom_nav_cubit.dart';

import 'package:flutter_bloc_task_app/screens/add_task_screen.dart';
import 'package:flutter_bloc_task_app/screens/completed_task.dart';
import 'package:flutter_bloc_task_app/screens/drawer.dart';
import 'package:flutter_bloc_task_app/screens/favorite_task.dart';
import 'package:flutter_bloc_task_app/screens/pending_task_screen.dart';

import '../blocs/bloc_export.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

var selectedIndex = 0;

class _TabScreenState extends State<TabScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> pageDetails = [
      {
        'pageName': const PendingTaskScreen(),
        'title': 'Pending Tasks',
      },
      {
        'pageName': const CompletedTask(),
        'title': 'Completed Tasks',
      },
      {
        'pageName': const FavoriteTask(),
        'title': 'Favorite Tasks',
      }
    ];

    void addTask(BuildContext context) {
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: const AddTaskScreen(),
          ),
        ),
      );
    }

    return BlocBuilder<BottomNavCubit, BottomNavState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(pageDetails[selectedIndex]['title']),
            actions: [
              IconButton(
                  onPressed: () => addTask(context),
                  icon: const Icon(Icons.add))
            ],
          ),
          body: 
          pageDetails[state.selectedIndex]['pageName'],
          
          
          // BlocBuilder<BottomNavCubit, BottomNavState>(
          //   builder: (context, state) {
          //     if (state.intIndex == IntIndex.pendingTasks) {
          //       return const PendingTaskScreen();
          //     } else if (state.intIndex == IntIndex.completedTasks) {
          //       return const CompletedTask();
          //     } else if (state.intIndex == IntIndex.favoriteTasks) {
          //       return const FavoriteTask();
          //     }

          //     return Container();
          //   },
          // ),
          // pageDetails[selectedIndex]['pageName'],
          drawer: const DrawerScreen(),
          floatingActionButton: state.selectedIndex == 0
              ? FloatingActionButton(
                  onPressed: () => addTask(context),
                  tooltip: 'Add Task',
                  child: const Icon(Icons.add),
                )
              : null,
          bottomNavigationBar: BlocBuilder<BottomNavCubit, BottomNavState>(
            builder: (context, state) {
              return BottomNavigationBar(
                  currentIndex: state.selectedIndex,
                  onTap: (value) {
                    context.read<BottomNavCubit>().onDestinationSelected(value);
                  },
            //          onTap: (index) {
            //   if (index == 0) {
            //     BlocProvider.of<BottomNavCubit>(context)
            //         .getNavBarItem(IntIndex.pendingTasks);
            //   } else if (index == 1) {
            //     BlocProvider.of<BottomNavCubit>(context)
            //         .getNavBarItem(IntIndex.completedTasks);
            //   } else if (index == 2) {
            //     BlocProvider.of<BottomNavCubit>(context)
            //         .getNavBarItem(IntIndex.favoriteTasks);
            //   }
            // },
                  items: const [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.list), label: 'Pending Task'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.done), label: 'Completed Task'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.favorite), label: 'Favorite Task')
                  ]);
            },
          ),
        );
      },
    );
  }
}
