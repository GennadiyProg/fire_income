import 'package:fire_income/features/dio_request.dart';
import 'package:fire_income/features/widget/range_selector_text_form_field.dart';
import 'package:fire_income/models/Organization.dart';
import 'package:fire_income/models/User.dart';
import 'package:flutter/material.dart';

import '../../styles/styles.dart';

class AddOrgForm extends StatelessWidget {
  const AddOrgForm({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    User chief = User.empty();
    Organization organization = Organization.empty();

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(10, 50, 10, 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RangeSelectorTextFormField(
              labelText: "Фамилия",
              valueSetter: (value) => chief.surname = value,
            ),
            const SizedBox(height: 20),
            RangeSelectorTextFormField(
              labelText: "Имя",
              valueSetter: (value) => chief.firstName = value,
            ),
            const SizedBox(height: 20),
            RangeSelectorTextFormField(
              labelText: "Отчество",
              valueSetter: (value) => chief.lastName = value,
            ),
            const SizedBox(height: 20),
            RangeSelectorTextFormField(
              labelText: "Паспорт",
              valueSetter: (value) => chief.passport = value,
            ),
            const SizedBox(height: 20),
            RangeSelectorTextFormField(
              labelText: "Пароль",
              valueSetter: (value) => chief.password = value,
            ),
            const SizedBox(height: 20),
            RangeSelectorTextFormField(
              labelText: "Название организации",
              valueSetter: (value) => organization.name = value,
            ),
            const SizedBox(height: 20),
            RangeSelectorTextFormField(
              labelText: "ИНН",
              valueSetter: (value) => organization.inn = value,
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
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                      _formKey.currentState?.save();
                      organization.director = chief;
                      final response = await DioRequest.postRequest(
                          'admin/createOrg', organization.toJson());
                      final data = response.data;
                      if (data != null && context.mounted) {
                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Successful'),
                            backgroundColor: styles.successColor,
                          ),
                        );
                        _formKey.currentState?.reset();
                      }
                      print(data.toString());
                    },
                    child: const Text('Submit'),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
