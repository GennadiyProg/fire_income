import 'package:fire_income/features/dio_request.dart';
import 'package:fire_income/features/list/seller_list.dart';
import 'package:fire_income/models/Branch.dart';
import 'package:flutter/material.dart';

class BranchInfoScreen extends StatefulWidget {
  var kpp;

  BranchInfoScreen(this.kpp, {super.key});

  @override
  State createState() {
    return _BranchInfoScreen();
  }
}

class _BranchInfoScreen extends State<BranchInfoScreen> {
  String kpp;
  Branch branch;
  bool isloading = false;

  _BranchInfoScreen()
      : branch = Branch.empty(),
        kpp = '';

  @override
  void initState() {
    isloading = true;
    setState(() {
      kpp = widget.kpp;
    });
    getBranch().then((value) => {
          setState(() {
            branch = value;
            isloading = false;
          })
        });
  }

  Future<Branch> getBranch() async {
    final response = await DioRequest.getRequest('branch/$kpp', {});
    final data = response.data as dynamic;
    print(data);
    return Branch.fromJson(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isloading
          ? Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 50),
              child: const CircularProgressIndicator(),
            )
          : Column(mainAxisSize: MainAxisSize.max, children: [
              ListTile(
                title: Text('${branch.city}, ${branch.street}, ${branch.house},'),
                subtitle: Text('${branch.kpp}'),
              ),
              Stack(children: [
                SellerList(branch.sellers),
                Flexible(
                  flex: 1,
                    child: Container(
                  alignment: Alignment.bottomRight,
                  padding: const EdgeInsets.all(15),
                  child: FloatingActionButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/chief/new_supervisor');
                      },
                      child: const Icon(Icons.add)),
                ))
              ])
            ]),
    );
  }
}
