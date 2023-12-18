import 'dart:developer';

import 'package:fire_income/features/dio_request.dart';
import 'package:fire_income/features/widget/show_snack_bar.dart';
import 'package:fire_income/models/User.dart';
import 'package:fire_income/styles/styles.dart';
import 'package:flutter/material.dart';

class SellerList extends StatefulWidget {
  final String kpp;
  final List<User> sellers;

  const SellerList(this.sellers, {super.key, required this.kpp});

  @override
  State<SellerList> createState() => _SellerListState();
}

class _SellerListState extends State<SellerList> {
  Future<void> deleteSeller(username) async {
    try {
      final res =
          await DioRequest.postRequest('branch/${widget.kpp}/sellers/$username/detach');
      setState(() {});
      if (mounted && res != null) {
        showDeleteSnackBar(context, text: "Продавец успешно откреплён");
      }
    } catch (e, s) {
      if (mounted) showErrorSnackBar(context, e);
      log("Error", error: e, stackTrace: s);
    }
  }

  @override
  Widget build(BuildContext context) {
    final sellers = widget.sellers;

    return sellers.isNotEmpty
        ? ListView.separated(
            itemCount: sellers.length,
            itemBuilder: (context, index) {
              final user = sellers[index];
              return ListTile(
                title: Text('${user.username}'),
                subtitle:
                    Text('${user.surname} ${user.firstName} ${user.lastName}'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  color: styles.dangerColor,
                  onPressed: () async {
                    await deleteSeller(user.username);
                  },
                ),
              );
            },
            separatorBuilder: (context, index) => const Divider(),
          )
        : const Text("Продавцы не найдены");
  }
}
