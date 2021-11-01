import 'package:flutter/material.dart';
import 'package:newest/provider/news_provider.dart';
import 'package:newest/screens/discover_screen.dart';
import 'package:newest/screens/home_screen.dart';
import 'package:newest/screens/news_screen.dart';
import 'package:newest/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: NewsProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            inputDecorationTheme: InputDecorationTheme(
                labelStyle: TextStyle(fontFamily: 'Charter'),
                hintStyle: TextStyle(fontFamily: 'Charter'))),
        initialRoute: SplashScreen.id,
        routes: {
          HomeScreen.id: (context) => HomeScreen(),
          NewsScreen.id: (context) => NewsScreen(),
          SplashScreen.id: (context) => SplashScreen(),
          DiscoverScreen.id: (context) => DiscoverScreen(),
        },
      ),
    );
  }
}
