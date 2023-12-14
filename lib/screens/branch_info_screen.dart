import 'dart:developer';

import 'package:fire_income/features/dio_request.dart';
import 'package:fire_income/features/form/add_seller_form.dart';
import 'package:fire_income/features/list/seller_list.dart';
import 'package:fire_income/models/Branch.dart';
import 'package:fire_income/styles/styles.dart';
import 'package:flutter/material.dart';

class BranchInfoScreen extends StatefulWidget {
  final String kpp;

  const BranchInfoScreen(this.kpp, {super.key});

  @override
  State createState() => _BranchInfoScreen();
}

class _BranchInfoScreen extends State<BranchInfoScreen> {
  Future<Branch> getBranch() async {
    final response = await DioRequest.getRequest('branch/${widget.kpp}', {});
    final data = response.data as dynamic;
    print(data);
    return Branch.fromJson(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.kpp)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddSellerForm(
                      widget.kpp,
                    )),
          ).then((value) => setState((){}));
        },
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: FutureBuilder(
          future: getBranch(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final branch = snapshot.data ?? Branch();
              final sellers = branch.sellers ?? [];

              return Column(
                children: [
                  ListTile(
                    title: Text(
                      '${branch.city}, ${branch.street}, ${branch.house}',
                    ),
                    subtitle: Text(branch.kpp ?? ''),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "Продавцы",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontSize: 18),
                  ),
                  Expanded(child: SellerList(sellers, kpp: widget.kpp)),
                ],
              );
            }

            if (snapshot.hasError) {
              log(snapshot.error.toString());
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
