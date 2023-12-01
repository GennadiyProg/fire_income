import 'package:fire_income/features/dio_request.dart';
import 'package:fire_income/features/widget/range_selector_text_form_field.dart';
import 'package:fire_income/models/Branch.dart';
import 'package:flutter/material.dart';

class AddBranchForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    Branch branch = Branch.empty();

    Future<String?> createBranch() async {
      final response = await DioRequest.postRequest('chief/branches/create', branch.toJson());
      final data = response.data as dynamic;
      print(data);
      return Branch.fromJson(data).kpp;
    }

    void goPrev(value) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Добавлен новый филиал $value')),
      );
      Navigator.pop(context);
    }

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 50, 10, 10),
        child: SingleChildScrollView(
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
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(children: <Widget>[
                  ConstrainedBox(
                    constraints: BoxConstraints.tight(const Size(200, 50)),
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                        _formKey.currentState?.save();
                        createBranch().then((value) => goPrev(value));
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
