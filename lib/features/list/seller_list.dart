import 'package:fire_income/features/dio_request.dart';
import 'package:fire_income/models/User.dart';
import 'package:flutter/material.dart';

class SellerList extends StatefulWidget {
  List<User>? sellers;

  SellerList(this.sellers, {super.key});

  @override
  State<SellerList> createState() => _SellerListState();
}

class _SellerListState extends State<SellerList> {
  List<User> sellers;

  _SellerListState() : sellers = List.empty();

  @override
  void initState() {
    sellers = widget.sellers!;
  }

  Future<dynamic> deleteSeller(username) async {
    //TODO заменить адрес на seller. Можно заменить на detattach
    return await DioRequest.deleteRequest('chief/supervisors/$username');
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Flexible(
          child: sellers.isNotEmpty
              ? ListView.builder(
                  itemCount: sellers.length,
                  itemBuilder: (context, index) {
                    final user = sellers[index];
                    return Row(
                      children: [
                        Expanded(
                            child: ListTile(
                          title: Text('${user.username}'),
                          subtitle: Text('${user.surname} ${user.firstName} ${user.lastName}'),
                        )),
                        TextButton(
                            onPressed: () => {deleteSeller(user.username).then((value) => initState())},
                            child: const Icon(Icons.delete))
                      ],
                    );
                  },
                )
              : Container(
                  alignment: Alignment.topCenter,
                  child: Text("Продавцы не найдены"),
                ))
    ]);
  }
}
