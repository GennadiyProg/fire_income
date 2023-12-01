import 'package:fire_income/features/form/add_org_form.dart';
import 'package:fire_income/features/list/supervisor_list.dart';
import 'package:fire_income/features/list/branch_list.dart';
import 'package:flutter/material.dart';

class ChiefScreen extends StatefulWidget{

  @override
  State createState() {
    return _ChiefScreen();
  }
}

class _ChiefScreen extends State<ChiefScreen> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    SupervisorList(),
    AddOrgForm(),
    BranchList(),
    AddOrgForm()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Персонал',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.area_chart),
              label: 'Статистика',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.location_city),
              label: 'Филиалы',
            ),
            BottomNavigationBarItem(
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