import 'package:fire_income/features/dio_request.dart';
import 'package:fire_income/models/User.dart';
import 'package:flutter/material.dart';

class SupervisorList extends StatefulWidget {
  @override
  State<SupervisorList> createState() => _SupervisorListState();
}

class _SupervisorListState extends State<SupervisorList> {
  bool isloading = false;
  List<User> supervisors;

  _SupervisorListState() : supervisors = List.empty();

  @override
  void initState() {
    isloading = true;

    getAllSupervisors().then((value) => {
          setState(() {
            supervisors = value;
            isloading = false;
          })
        });
  }

  Future<List<User>> getAllSupervisors() async {
    final response = await DioRequest.getRequest('chief/supervisors', {});
    final data = response.data as List<dynamic>;
    print(data);
    return data.map((e) => User.fromJson(e)).toList();
  }

  Future<dynamic> deleteSupervisor(username) async {
    return await DioRequest.deleteRequest('chief/supervisors/$username');
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
                  child: supervisors.isNotEmpty
                      ? ListView.builder(
                          itemCount: supervisors.length,
                          itemBuilder: (context, index) {
                            final user = supervisors[index];
                            return Row(
                              children: [
                                Expanded(
                                    child: ListTile(
                                      title: Text('${user.username}'),
                                      subtitle: Text(
                                          '${user.surname} ${user.firstName} ${user.lastName}'),
                                    )
                                ),
                                TextButton(
                                    onPressed: () => {
                                          deleteSupervisor(user.username).then((value) => initState())
                                        },
                                    child: const Icon(Icons.delete))
                              ],
                            );
                          },
                        )
                      : const Text("Супервайзеры не найдены")),
        ],
      ),
      Container(
        alignment: Alignment.bottomRight,
        padding: const EdgeInsets.all(15),
        child: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, '/chief/new_supervisor');
            },
            child: const Icon(Icons.add)),
      )
    ]);
  }
}
