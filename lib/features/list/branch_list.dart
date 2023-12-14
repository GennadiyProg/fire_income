import 'dart:developer';

import 'package:fire_income/features/dio_request.dart';
import 'package:fire_income/features/widget/show_snack_bar.dart';
import 'package:fire_income/models/Branch.dart';
import 'package:fire_income/screens/branch_info_screen.dart';
import 'package:fire_income/styles/styles.dart';
import 'package:flutter/material.dart';

class BranchList extends StatefulWidget {
  const BranchList({super.key});

  @override
  State<BranchList> createState() => _BranchListState();
}

class _BranchListState extends State<BranchList> {
  List<Branch> branches = List.empty();

  Future<List<Branch>> getAllBranches() async {
    final response = await DioRequest.getRequest('branch/all', {});
    final data = response.data as List<dynamic>;
    print(data);
    return data.map((e) => Branch.fromJson(e)).toList();
  }

  Future<dynamic> deleteBranch(kpp) async {
    try {
      final res = await DioRequest.deleteRequest('chief/branches/$kpp');
      setState(() {});
      if (mounted && res != null) {
        showDeleteSnackBar(context);
      }
    } catch (e) {
      if (mounted) showErrorSnackBar(context, e);
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/chief/new_branch')
              .then((value) => setState(() {}));
        },
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: FutureBuilder(
          future: getAllBranches(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final branches = snapshot.data ?? [];
              return branches.isNotEmpty
                  ? ListView.separated(
                      itemCount: branches.length,
                      itemBuilder: (context, index) {
                        final branch = branches[index];
                        return ListTile(
                          title: Text(
                              '${branch.city}, ${branch.street}, ${branch.house}'),
                          subtitle: Text('${branch.kpp}'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            color: styles.dangerColor,
                            onPressed: () async {
                              await deleteBranch(branch.kpp);
                            },
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => BranchInfoScreen(
                                        branch.kpp ?? ''
                                      )),
                            );
                          },
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(),
                    )
                  : const Text("Филиалы не найдены");
            }

            if (snapshot.hasError) {
              log(snapshot.error.toString(), stackTrace: snapshot.stackTrace);
              return Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              );
            }

            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
