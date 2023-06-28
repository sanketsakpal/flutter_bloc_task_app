import 'package:flutter/material.dart';
import 'package:flutter_bloc_task_app/blocs/bloc_export.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                color: Colors.grey,
                child: Text(
                  "Task Drawer",
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              BlocBuilder<SwitchBloc, SwitchState>(
                builder: (context, state) {
                  return Switch(
                      value: state.switchValue,
                      onChanged: (value) {
                        value
                            ? context.read<SwitchBloc>().add(SwitchOnEvent())
                            : context.read<SwitchBloc>().add(SwitchOffEvent());
                      });
                },
              ),
              BlocBuilder<TasksBloc, TasksState>(
                builder: (context, state) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed("/");
                    },
                    child: ListTile(
                      leading: const Icon(Icons.folder_special),
                      title: const Text("My Task"),
                      trailing: Text(
                          "${state.pendingTask.length}  | ${state.completedTask.length}"),
                    ),
                  );
                },
              ),
              const Divider(),
              // BlocBuilder<TasksBloc, TasksState>(
              //   builder: (context, state) {
              //     return GestureDetector(
              //       onTap: (() {
              //         Navigator.of(context)
              //             .pushReplacementNamed("/recycle_bin");
              //       }),
              //       child: ListTile(
              //         leading: const Icon(Icons.folder_special),
              //         title: const Text("Bin"),
              //         trailing: Text("${state.removeTask.length} Task"),
              //       ),
              //     );
              //   },
              // ),
              // const Divider(),
              // GestureDetector(
              //   onTap: () {
              //     Navigator.pushNamed(context, "/post_view");
              //   },
              //   child: const ListTile(
              //     leading: Icon(Icons.feed_rounded),
              //     title: Text("Post View"),
              //     trailing: Text("Posts"),
              //   ),
              // ),
              // const Divider(),
              // GestureDetector(
              //   onTap: () {
              //     Navigator.pushNamed(context, "/counter");
              //   },
              //   child: const ListTile(
              //     leading: Icon(Icons.add_circle_outline_rounded),
              //     title: Text("counter View"),
              //     trailing: Text("counter"),
              //   ),
              // ),
              // const Divider(),
              // GestureDetector(
              //   onTap: () {
              //     Navigator.pushNamed(context, "/counterBloc");
              //   },
              //   child: const ListTile(
              //     leading: Icon(Icons.add_circle_outline_rounded),
              //     title: Text("counter Bloc View"),
              //     trailing: Text("counter Bloc"),
              //   ),
              // ),
              // const Divider(),
              // GestureDetector(
              //   onTap: () {
              //     Navigator.pushNamed(context, "/CubitToCubit");
              //   },
              //   child: const ListTile(
              //     leading: Icon(Icons.add_circle_outline_rounded),
              //     title: Text("cubit to cubit"),
              //     trailing: Text("communication"),
              //   ),
              // ),
              // const Divider(),
              // GestureDetector(
              //   onTap: () {
              //     Navigator.pushNamed(context, "/TaskApp");
              //   },
              //   child: const ListTile(
              //     leading: Icon(Icons.task),
              //     title: Text("Udemy Task"),
              //     trailing: Text("Task"),
              //   ),
              // ),
              // const Divider(),
              // GestureDetector(
              //   onTap: () {
              //     Navigator.pushNamed(context, "/CovidDataScreen");
              //   },
              //   child: const ListTile(
              //     leading: Icon(Icons.coronavirus),
              //     title: Text("covid data"),
              //     trailing: Text("covid data api"),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
