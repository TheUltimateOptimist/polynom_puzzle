import 'package:flutter/material.dart';
import 'package:polynom_puzzle/logic/blocs/puzzle_cubit.dart';
import 'package:polynom_puzzle/presentation/lobby.dart';
import 'package:polynom_puzzle/presentation/my_home_page.dart';
import 'package:polynom_puzzle/presentation/new_home_page.dart';
import 'package:polynom_puzzle/presentation/profile.dart';
import 'package:polynom_puzzle/presentation/puzzle_ui.dart';
import 'package:polynom_puzzle/presentation/ranking.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => ResponsiveWrapper.builder(
        child,
      ),
      title: 'Polynom Puzzle',
      home: BlocProvider(
        create: (context) => PuzzleCubit(),
        child: MyHomePage(title: "PolynomPuzzle",)
      ),
    );
  }
}
