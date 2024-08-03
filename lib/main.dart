import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:show_data/bloc/instructor_bloc.dart';
import 'package:show_data/repository/instructor_repository.dart';
import 'package:show_data/screens/home.dart';

void main() {
  runApp(BlocProvider(
    create: (context) => InstructorBloc(InstructorRepository()),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
