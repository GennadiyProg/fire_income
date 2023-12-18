import 'package:fire_income/screens/add_branch_screen.dart';
import 'package:fire_income/screens/add_supervisor_screen.dart';
import 'package:fire_income/screens/admin_screen.dart';
import 'package:fire_income/screens/branch_info_screen.dart';
import 'package:fire_income/screens/chief_screen.dart';
import 'package:fire_income/screens/login_screen.dart';
import 'package:fire_income/screens/seller_screen.dart';
import 'package:fire_income/screens/statistic_screen.dart';
import 'package:fire_income/screens/supervisor_screen.dart';
import 'package:fire_income/styles/styles.dart';
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
      theme: styles.mainTheme,
      routes: {
        '/login': (context) => LoginScreen(),
        '/admin': (context) => const AdminScreen(),
        '/chief': (context) => const ChiefScreen(),
        '/supervisor': (context) => const SupervisorScreen(),
        '/seller': (context) => const SellerScreen(),
        '/chief/new_supervisor': (context) => AddSupervisorScreen(),
        '/chief/new_branch': (context) => const AddBranchScreen(),
        '/chief/statistic': (context) => const StatisticScreen(),
      },
      initialRoute: '/login',
      debugShowCheckedModeBanner: false,
    );
  }
}
