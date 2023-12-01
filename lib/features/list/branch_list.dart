import 'package:fire_income/features/dio_request.dart';
import 'package:fire_income/models/Branch.dart';
import 'package:flutter/material.dart';

class BranchList extends StatefulWidget {
  @override
  State<BranchList> createState() => _BranchListState();
}

class _BranchListState extends State<BranchList> {
  bool isloading = false;
  List<Branch> branches;

  _BranchListState() : branches = List.empty();

  @override
  void initState() {
    isloading = true;

    getAllBranches().then((value) => {
          setState(() {
            branches = value;
            isloading = false;
          })
        });
  }

  Future<List<Branch>> getAllBranches() async {
    final response = await DioRequest.getRequest('branch/all', {});
    final data = response.data as List<dynamic>;
    print(data);
    return data.map((e) => Branch.fromJson(e)).toList();
  }

  Future<dynamic> deleteBranch(kpp) async {
    return await DioRequest.deleteRequest('chief/branches/$kpp');
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Column(
        children: [
          isloading
              ? Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(top: 50),
                  child: const CircularProgressIndicator(),
                )
              : Expanded(
                  child: branches.isNotEmpty
                      ? ListView.builder(
                          itemCount: branches.length,
                          itemBuilder: (context, index) {
                            final branch = branches[index];
                            return Row(
                              children: [
                                Expanded(
                                    child: ListTile(
                                  title: Text('${branch.city}, ${branch.street}, ${branch.house},'),
                                  subtitle: Text('${branch.kpp}'),
                                )),
                                TextButton(
                                    onPressed: () => Navigator.pushNamed(context, '/branch_info', arguments: branch.kpp),
                                    child: const Icon(Icons.edit_note)),
                                TextButton(
                                    onPressed: () => {deleteBranch(branch.kpp).then((value) => initState())},
                                    child: const Icon(Icons.delete))
                              ],
                            );
                          },
                        )
                      : Container(
                          alignment: Alignment.center,
                          child: Text("Филиалы не найдены"),
                        )),
        ],
      ),
      Container(
        alignment: Alignment.bottomRight,
        padding: const EdgeInsets.all(15),
        child: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, '/chief/new_branch');
            },
            child: const Icon(Icons.add)),
      )
    ]);
  }
}
