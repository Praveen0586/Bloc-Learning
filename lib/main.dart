import 'package:flutter/material.dart';
import 'package:flutter_application_2/bloc/counter_bloc.dart';
import 'package:flutter_application_2/bloc/event.dart';
import 'package:flutter_application_2/bloc/increment_state.dart';
import 'package:flutter_application_2/visibilityBloc/visibilityEvent.dart';
import 'package:flutter_application_2/visibilityBloc/visibilityState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_2/visibilityBloc/visibiltyBloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => CounterBloc()),
          BlocProvider(create: (context) => Visibiltybloc())
        ],
        child: MyHomePage(title: "BlockApp"),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  final countersb = CounterBloc();

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // TRY THIS: Try changing the color here to a specific color (to
          // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
          // change color while the other colors stay the same.
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
            // Column is also a layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).
            //
            // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
            // action in the IDE, or press "p" in the console), to see the
            // wireframe for each widget.
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              BlocBuilder<CounterBloc, CounterState>(
                  buildWhen: (previous, current) {
                print(previous.count);
                print(current.count);
                return true;
              }, builder: (context, state) {
                return Text(
                  state.count.toString(),
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              }),
              BlocBuilder<Visibiltybloc, Visibilitystate>(
                builder: (context, state) {
                  return Visibility(
                    visible: state.visible,
                    child: Container(
                      height: 100,
                      width: 100,
                      color: Colors.green,
                    ),
                  );
                },
              )
            ],
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton(
              onPressed: () {
                // countersb.add(CounterIncrementEvent());

                context.read<CounterBloc>().add(CounterIncrementEvent());
              },
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
            FloatingActionButton(
              onPressed: () {
                // countersb.add(CounterDecrementEvent());
                context.read<CounterBloc>().add(CounterDecrementEvent());
              },
              tooltip: 'Decrement',
              child: const Icon(Icons.minimize),
            ),
            FloatingActionButton(
              onPressed: () {
                // countersb.add(CounterIncrementEvent());

                context.read<Visibiltybloc>().add(VisiBilityShowEevent());
              },
              tooltip: 'show',
              child: Text("Show"),
            ),
            FloatingActionButton(
              onPressed: () {
                // countersb.add(CounterIncrementEvent());

                context.read<Visibiltybloc>().add(VisibilityHideEvent());
              },
              tooltip: 'hide',
              child: Text("Hide"),
            ),
          ],
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
