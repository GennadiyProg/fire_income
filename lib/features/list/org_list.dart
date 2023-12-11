import 'dart:core';
import 'dart:developer';

import 'package:fire_income/features/dio_request.dart';
import 'package:fire_income/models/Organization.dart';
import 'package:flutter/material.dart';

class OrgList extends StatefulWidget {
  const OrgList({super.key});

  @override
  State<OrgList> createState() => _OrgListState();
}

class _OrgListState extends State<OrgList> {
  Future<List<Organization>> getAllOrgs() async {
    final response = await DioRequest.getRequest('admin/orgs', {});
    final data = response.data as List<dynamic>;
    return data.map((e) => Organization.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
        future: getAllOrgs(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final orgs = snapshot.data ?? [];
            return orgs.isNotEmpty
                ? ListView.separated(
                    itemCount: orgs.length,
                    itemBuilder: (context, index) {
                      final org = orgs[index];
                      return ListTile(
                        title: Text(org.name ?? ''),
                        subtitle: Text(org.inn ?? ''),
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(),
                  )
                : const Text("Организаций нет");
          }

          if (snapshot.hasError) {
            return Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text('Error: ${snapshot.error}'),
            );
          }

          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
