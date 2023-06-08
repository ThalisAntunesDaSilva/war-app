import 'package:flutter/material.dart';
import 'package:todo_list/pages/todo_list_page.dart';
import 'package:todo_list/pages/register_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => TodoListPage(),
        '/register': (context) => RegisterPage(),
      },
      theme: ThemeData(
        fontFamily: 'Alata',
      ),
    );
  }
}
