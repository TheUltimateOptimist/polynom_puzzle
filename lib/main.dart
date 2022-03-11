import 'package:firebase_core/firebase_core.dart';
import 'package:polynom_puzzle/logic/blocs/user_cubit.dart';
import 'package:polynom_puzzle/logic/models/backEnd.dart';
import 'package:polynom_puzzle/presentation/home_page.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:polynom_puzzle/logic/models/user.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
   BackEnd().initialize();
  await PuzzleUser().initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit(),
      child: MaterialApp(
        builder: (context, child) => ResponsiveWrapper.builder(
          child,
        ),
        routes: {
          "/login": (context) => const HomePage(),
        },
        initialRoute: "/login",
        title: 'Polynom Puzzle',
      ),
    );
  }
}
