import 'dart:core';

import 'package:fire_income/features/dio_request.dart';
import 'package:fire_income/models/Organization.dart';
import 'package:flutter/material.dart';

class OrgList extends StatefulWidget {
  @override
  State<OrgList> createState() => _OrgListState();
}

class _OrgListState extends State<OrgList> {
  bool isloading = false;
  List<Organization> orgs;

  _OrgListState()
      : orgs = List.empty();

  @override
  void initState() {
    isloading = true;

    getAllOrgs().then((value) => {
      setState(() {
        orgs = value;
        isloading = false;
      })
    });
  }

  Future<List<Organization>> getAllOrgs() async {
    final response = await DioRequest.getRequest('admin/orgs', {});
    final data = response.data as List<dynamic>;
    return data.map((e) => Organization.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              itemCount: orgs.length,
              itemBuilder: (context, index) {
                final org = orgs[index];
                return ListTile(
                  title: Text(org.name ?? ''),
                  subtitle: Text(org.inn ?? ''),
                );
              },
          ),
        ),
        isloading
            ? Container(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(),
            )
            : Text("")
      ],
    );
  }
}