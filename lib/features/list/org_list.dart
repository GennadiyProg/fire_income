import 'dart:convert';
import 'dart:core';

import 'package:dio/dio.dart';
import 'package:fire_income/models/Organization.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class OrgList extends StatelessWidget {
  List<Organization> orgs;


  OrgList({super.key})
    : orgs = List.empty() {
    getAllOrgs().then((value) => orgs = value);
  }

  Future<List<Organization>> getAllOrgs() async {
    final response = await Dio().get('http://192.168.0.10:8080/admin/orgs');
    final data = response.data as List<dynamic>;
    return data.map((e) => Organization.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    getAllOrgs().then((value) => null)
    return ListView.builder(
      itemCount: 2,
      itemBuilder: (context, index) {
        final org = orgs[index];
        return ListTile(
          title: Text(org.name ?? ''),
          subtitle: Text(org.inn ?? ''),
        );
      },
    );
  }
}