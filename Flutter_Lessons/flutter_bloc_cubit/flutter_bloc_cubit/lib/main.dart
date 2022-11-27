import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_cubit/bloc_counter/counter_bloc.dart';
import 'package:flutter_bloc_cubit/cubit_counter/counter_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CounterCubit(),
        ),
        BlocProvider(
          create: (context) => CounterBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        //home: const MyHomePageWithCubit(),
        home: const MyHomePageWithBloc(),
      ),
    );
  }
}

class MyHomePageWithCubit extends StatelessWidget {
  const MyHomePageWithCubit({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    debugPrint('Trigged Print');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cubit Kullanımı'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            // Bu Şekilde Olursa Her Event Sırasında Build Tekrar Çalışır. Yani debugPrint('Trigged Print'); Her Seferinde Çalışır.
            // Text(
            //   context.watch<CounterCubit>().state.counter.toString(),
            //   style: Theme.of(context).textTheme.headline4,
            // ),

            // Bu Şekilde Olursa  Build 1 Kere Çalışır.
            BlocBuilder<CounterCubit, CounterCubitState>(
              builder: (context, CounterCubitState state) {
                return Text(
                  state.counter.toString(),
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              context.read<CounterCubit>().increment();
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: () {
              context.read<CounterCubit>().decrement();
            },
            tooltip: 'Decrement',
            child: const Icon(Icons.minimize),
          ),
        ],
      ),
    );
  }
}

class MyHomePageWithBloc extends StatelessWidget {
  const MyHomePageWithBloc({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    debugPrint('Trigged Print');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cubit Kullanımı'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            // Bu Şekilde Olursa Her Event Sırasında Build Tekrar Çalışır. Yani debugPrint('Trigged Print'); Her Seferinde Çalışır.
            // Text(
            //   context.watch<CounterCubit>().state.counter.toString(),
            //   style: Theme.of(context).textTheme.headline4,
            // ),

            // Bu Şekilde Olursa  Build 1 Kere Çalışır.
            BlocBuilder<CounterBloc, CounterBlocState>(
              builder: (context, CounterBlocState state) {
                return Text(
                  state.counter.toString(),
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              context.read<CounterBloc>().add(IncrementCounterEvent());
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: () {
              context.read<CounterBloc>().add(DecrementCounterEvent());
            },
            tooltip: 'Decrement',
            child: const Icon(Icons.minimize),
          ),
        ],
      ),
    );
  }
}
