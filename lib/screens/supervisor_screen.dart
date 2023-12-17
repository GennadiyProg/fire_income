import 'package:fire_income/features/form/add_org_form.dart';
import 'package:fire_income/features/list/category_list.dart';
import 'package:fire_income/features/list/supervisor_list.dart';
import 'package:fire_income/features/list/branch_list.dart';
import 'package:flutter/material.dart';

class SupervisorScreen extends StatefulWidget{
  const SupervisorScreen({super.key});

  @override
  State createState() => _SupervisorScreen();

}

class _SupervisorScreen extends State<SupervisorScreen> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    const BranchList(role: "SUPERVISOR"),
    const CategoryList()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: NavigationBar(
          onDestinationSelected: onTabTapped,
          selectedIndex: _currentIndex,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.location_city),
              label: 'Филиалы',
            ),
            NavigationDestination(
              icon: Icon(Icons.shopping_cart),
              label: 'Товары',
            )
          ]
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}