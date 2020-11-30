import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/bloc/megu_bloc.dart';
import 'package:todo_list_app/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo List Application',
      theme: ThemeData(
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Color(0xFF3068DE),
        ),
        primaryColor: Color(0xFF3068DE),
        accentColor: Color(0xFF3068DE),
        fontFamily: 'Roboto',
        textTheme: TextTheme(
          headline6: TextStyle(fontSize: 24.0),
          bodyText2: TextStyle(color: Color(0xFF3D3D49)),
        ),
        scaffoldBackgroundColor: Color(0xFFF4F4F7),
        appBarTheme: AppBarTheme(
          brightness: Brightness.light,
          color: Colors.white,
        ),
      ),
      home: BlocProvider(
        create: (context) => MeguBloc(),
        child: HomeScreen(),
      ),
    );
  }
}
