import 'package:fire_income/features/dio_request.dart';
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

  Future<dynamic> deleteSeller(username) async {
    return await DioRequest.deleteRequest(
        'branch/${widget.kpp}/sellers/detach');
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
                  onPressed: () {
                    deleteSeller(user.username);
                  },
                ),
              );
            },
            separatorBuilder: (context, index) => const Divider(),
          )
        : const Text("Продавцы не найдены");
  }
}
