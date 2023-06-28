

import 'package:flutter/material.dart';
import 'package:flutter_bloc_task_app/blocs/bloc_export.dart';
import 'package:flutter_bloc_task_app/cubits/counter_cubit/counter_cubit.dart';

class Counter extends StatelessWidget {
  const Counter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterCubit(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(),
            body: BlocConsumer<CounterCubit, CounterState>(
              listener: (context, state) {
                if (state.counter == 3) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text('counter is ${state.counter}'),
                      );
                    },
                  );
                } else if (state.counter == -1) {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) {
                  //     return OtherPage();
                  //   }),
                  // );
                }
              },
              builder: (context, state) {
                return Center(
                  child: Text(
                    '${state.counter}',
                    style: const TextStyle(fontSize: 52.0),
                  ),
                );
              },
            ),
            floatingActionButton: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    context.read<CounterCubit>().increment();
                  },
                  heroTag: 'increment',
                  child: const Icon(Icons.add),
                ),
                const SizedBox(width: 10.0),
                FloatingActionButton(
                  onPressed: () {
                    context.read<CounterCubit>().decrement();
                  },
                  heroTag: 'decrement',
                  child: const Icon(Icons.remove),
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}
