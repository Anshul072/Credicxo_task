import 'package:credicxo_task/connectivity_provider.dart';
import 'package:credicxo_task/home.dart';
import 'package:credicxo_task/repo.dart';
import 'package:credicxo_task/tracksBloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) =>ConnectivityProvider(),
          child: BlocProvider(
            create: (BuildContext context) => TracksBloc(TracksIsLoading(), TrackRepo()),
            child: const Home(),
          ),
        )
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            // is not restarted.
            primarySwatch: Colors.grey,
          ),
          home: BlocProvider(
            create: (BuildContext context) => TracksBloc(TracksIsLoading(), TrackRepo()),
            child: const Home(),
          )
      ),
    );
  }
}
