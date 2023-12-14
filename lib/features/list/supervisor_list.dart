import 'dart:developer';

import 'package:fire_income/features/dio_request.dart';
import 'package:fire_income/features/widget/show_snack_bar.dart';
import 'package:fire_income/models/User.dart';
import 'package:fire_income/styles/styles.dart';
import 'package:flutter/material.dart';

class SupervisorList extends StatefulWidget {
  const SupervisorList({super.key});

  @override
  State<SupervisorList> createState() => _SupervisorListState();
}

class _SupervisorListState extends State<SupervisorList> {
  Future<List<User>> getAllSupervisors() async {
    final response = await DioRequest.getRequest('chief/supervisors', {});
    final data = response.data as List<dynamic>;
    print(data);
    return data.map((e) => User.fromJson(e)).toList();
  }

  Future<void> deleteSupervisor(username) async {
    try {
      final res = await DioRequest.deleteRequest('chief/supervisors/$username');
      setState(() {});
      if (mounted && res != null) {
        showDeleteSnackBar(context);
      }
    } catch (e, s) {
      if (mounted) showErrorSnackBar(context, e);
      log("Error", error: e, stackTrace: s);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/chief/new_supervisor')
              .then((value) => setState(() {}));
        },
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: FutureBuilder(
          future: getAllSupervisors(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final supervisors = snapshot.data ?? [];
              return supervisors.isNotEmpty
                  ? ListView.separated(
                      itemCount: supervisors.length,
                      itemBuilder: (context, index) {
                        final user = supervisors[index];
                        return ListTile(
                          title: Text(user.username ?? ''),
                          subtitle: Text(
                              "${user.surname} ${user.firstName} ${user.lastName}"),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            color: styles.dangerColor,
                            onPressed: () async {
                              await deleteSupervisor(user.username);
                            },
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(),
                    )
                  : const Text("Супервайзеры не найдены");
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
