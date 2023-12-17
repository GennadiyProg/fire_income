import 'package:fire_income/features/form/add_org_form.dart';
import 'package:fire_income/features/form/sale_form.dart';
import 'package:fire_income/features/list/category_list.dart';
import 'package:fire_income/features/list/supervisor_list.dart';
import 'package:fire_income/features/list/branch_list.dart';
import 'package:flutter/material.dart';

class SellerScreen extends StatefulWidget{
  const SellerScreen({super.key});

  @override
  State createState() => _SellerScreen();
}

class _SellerScreen extends State<SellerScreen> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    const CategoryList(),
    const AddSaleForm(),
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
              icon: Icon(Icons.shopping_cart),
              label: 'Товары',
            ),
            NavigationDestination(
              icon: Icon(Icons.add_shopping_cart),
              label: 'Продажи',
            ),
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