import 'package:fire_income/features/dio_request.dart';
import 'package:fire_income/features/process_data.dart';
import 'package:fire_income/features/widget/range_selector_text_form_field.dart';
import 'package:fire_income/models/Branch.dart';
import 'package:flutter/material.dart';

import '../../styles/styles.dart';

class AddBranchForm extends StatefulWidget {
  const AddBranchForm({super.key});

  @override
  State<AddBranchForm> createState() => _AddBranchFormState();
}

class _AddBranchFormState extends State<AddBranchForm> {
  final _formKey = GlobalKey<FormState>();

  Future<void> createBranch(Branch branch) async {
    await processDataSnack(
      context,
      () async {
        _formKey.currentState?.save();
        final response = await DioRequest.postRequest(
          'chief/branches/create',
          branch.toJson(),
        );
        final data = response.data as dynamic;
        _formKey.currentState?.reset();
        return data;
      },
      successBuilder: (data) =>
          'Добавлен новый филиал ${Branch.fromJson(data).kpp}',
    );

    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    Branch branch = Branch.empty();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Добавить филиал"),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RangeSelectorTextFormField(
                labelText: "Город",
                valueSetter: (value) => branch.city = value,
              ),
              const SizedBox(height: 20),
              RangeSelectorTextFormField(
                labelText: "Улица",
                valueSetter: (value) => branch.street = value,
              ),
              const SizedBox(height: 20),
              RangeSelectorTextFormField(
                labelText: "Дом",
                valueSetter: (value) => branch.house = value,
              ),
              const SizedBox(height: 20),
              RangeSelectorTextFormField(
                labelText: "КПП",
                valueSetter: (value) => branch.kpp = value,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(children: <Widget>[
                  ConstrainedBox(
                    constraints: BoxConstraints.tight(const Size(200, 50)),
                    child: ElevatedButton(
                      onPressed: () async {
                        await createBranch(branch);
                      },
                      child: const Text('Submit'),
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
