import 'package:cinema_application/Screens/start_splash_screen.dart';
import 'package:cinema_application/providers/movie_models.api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(MyApp());

}

class MyApp extends StatefulWidget {
  MovieModelApi movieModelApi=MovieModelApi();
  MyApp(){
    movieModelApi.getData();
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) =>
        MovieModelApi(), child: MaterialApp(
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: startSplashScreen(),),
    );
  }
}
