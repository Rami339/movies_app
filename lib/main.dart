import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/core/bloc_observer/bloc_observer.dart';
import 'package:movie_app/movies/presentation/screens/movies_screen.dart';
import 'core/services/services_locator.dart';

void main() {
  ServicesLocator.init();

  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MoviesScreen(),
    );
  }
}
