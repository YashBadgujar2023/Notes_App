import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/Background/background.dart';
import 'package:notes_app/Routes/app_routing_config.dart';
import 'package:notes_app/Screen/onboarding/onboarding.dart';
import 'package:notes_app/bloc/Notes_bloc.dart';
import 'package:notes_app/database/db_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  runApp(MyApp(preferences: preferences));
}

class MyApp extends StatelessWidget {
  final SharedPreferences? preferences;

  const MyApp({super.key, required this.preferences});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotesBloc(DB_helper: db_helper.db),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData.light(),
        themeMode: ThemeMode.system,
        darkTheme: ThemeData.dark(),
        routerConfig: MyAppRoute.goRouter(
            preferences!.getBool("onboarding"), preferences!.getBool('lock')),
        // routeInformationParser: MyAppRoute.goRouter(false).routeInformationParser,
        // routerDelegate: MyAppRoute.goRouter(false).routerDelegate,
      ),
    );
  }
}