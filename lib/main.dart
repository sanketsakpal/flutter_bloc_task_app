import 'package:flutter/material.dart';
import 'package:flutter_bloc_task_app/cubits/bottom_nav_cubit/bottom_nav_cubit.dart';
import 'package:flutter_bloc_task_app/cubits/todo_app_cubits/active_count_cubit/active_count_cubit.dart';
import 'package:flutter_bloc_task_app/cubits/todo_app_cubits/filter_todo_cubit/filter_todo_cubit.dart';
import 'package:flutter_bloc_task_app/cubits/todo_app_cubits/search_cubit/todo_search_cubit.dart';

import 'package:flutter_bloc_task_app/cubits/todo_app_cubits/todo_list_cubit/todo_list_cubit.dart';
import 'package:flutter_bloc_task_app/repositories/posts_repository.dart';
import 'package:flutter_bloc_task_app/service/app_router.dart';
import 'package:flutter_bloc_task_app/service/app_theme.dart';
import 'package:flutter_bloc_task_app/service/post_service.dart';
import 'package:path_provider/path_provider.dart';

import 'blocs/bloc_export.dart';
import 'cubits/todo_app_cubits/filter_cubit/filter_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());
  runApp(
    MyApp(
      repository: PostsRepository(
        PostsService(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final PostsRepository repository;
  const MyApp({super.key, required this.repository});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TasksBloc()),
        BlocProvider(create: (context) => SwitchBloc()),
        BlocProvider(create: (context) => BottomNavCubit()),
        BlocProvider(create: (context) => FilterCubit()),
        BlocProvider(
          create: (context) => ActiveCountCubit(
            todoListCubit: TodoListCubit(),
          ),
        ),
        BlocProvider(
          create: (context) => TodoListCubit(),
        ),
        BlocProvider(
          create: (context) => TodoSearchCubit(),
        ),
        BlocProvider(
          create: (context) => FilterTodoCubit(
            initialTodo: context.read<TodoListCubit>().state.todo,
            todoFilterCubit: BlocProvider.of<FilterCubit>(context),
            todoListCubit: BlocProvider.of<TodoListCubit>(context),
            todoSearchCubit: BlocProvider.of<TodoSearchCubit>(context),
          ),
        ),
        // BlocProvider(
        //   create: (context) => PostsCubit(repository),
        // )
      ],
      child: BlocBuilder<SwitchBloc, SwitchState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: state.switchValue
                ? AppThemes.appThemeData[AppTheme.darkTheme]
                : AppThemes.appThemeData[AppTheme.lightTheme],
            //  home:  const TabScreen(),
            onGenerateRoute: AppRouter().onGenerateRoute,
          );
        },
      ),
    );
  }
}
