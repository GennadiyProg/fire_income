import 'package:fire_income/features/form/add_org_form.dart';
import 'package:fire_income/features/list/org_list.dart';
import 'package:flutter/material.dart';

class AdminScreen extends StatefulWidget{
  const AdminScreen({super.key});

  @override
  State createState() {
    return _AdminScreen();
  }
}

class _AdminScreen extends State<AdminScreen> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    const OrgList(),
    const AddOrgForm()
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
              icon: Icon(Icons.home),
              label: 'Организации',
            ),
            NavigationDestination(
              icon: Icon(Icons.add),
              label: 'Добавить организацию',
            )
          ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}