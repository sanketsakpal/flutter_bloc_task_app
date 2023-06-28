import 'package:flutter/material.dart';
import 'package:flutter_bloc_task_app/blocs/bloc_export.dart';
import 'package:flutter_bloc_task_app/cubits/color_cubit/color_cubit.dart';
import 'package:flutter_bloc_task_app/cubits/counter_color_cubit/counter_color_cubit.dart';

class CubitToCubit extends StatelessWidget {
  const CubitToCubit({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ColorCubit>(
          create: (context) => ColorCubit(),
        ),
        BlocProvider<CounterColorCubit>(
          create: (context) => CounterColorCubit(colorCubit: context.read<ColorCubit>()),
        )
      ],
      child: 
          Builder(
            builder: (context) {
              return Scaffold(
                backgroundColor: context.watch<ColorCubit>().state.color,
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        child: const Text(
                          'Change Color',
                          style: TextStyle(fontSize: 24.0),
                        ),
                        onPressed: () {
                          context.read<ColorCubit>().colorChange();
                        },
                      ),
                      const SizedBox(height: 20.0),
                       Text(
                         '${context.watch<CounterColorCubit>().state.counter}',
                        style: const TextStyle(
                          fontSize: 52.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      ElevatedButton(
                        child: const Text(
                          'Increment Counter',
                          style: TextStyle(fontSize: 24.0),
                        ),
                        onPressed: () {
                          context.read<CounterColorCubit>().changeCounter();
                        },
                      ),
                    ],
                  ),
                ),
              );
            }
          ),);
        
      
  
  }
}
