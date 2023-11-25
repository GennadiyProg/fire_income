import 'package:fire_income/features/form/add_supervisor_form.dart';
import 'package:fire_income/screens/add_supervisor_screen.dart';
import 'package:fire_income/screens/admin_screen.dart';
import 'package:fire_income/screens/chief_screen.dart';
import 'package:fire_income/screens/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/login': (context) => LoginScreen(),
        '/admin': (context) => AdminScreen(),
        '/chief': (context) => ChiefScreen(),
        '/chief/new_supervisor': (context) => AddSupervisorScreen(),
      },
      initialRoute: '/login',
    );
  }
}