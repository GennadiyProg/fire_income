import 'package:fire_income/features/dio_request.dart';
import 'package:fire_income/features/process_data.dart';
import 'package:fire_income/features/widget/range_selector_text_form_field.dart';
import 'package:fire_income/models/Organization.dart';
import 'package:fire_income/models/User.dart';
import 'package:flutter/material.dart';

import '../../styles/styles.dart';

class AddOrgForm extends StatefulWidget {
  const AddOrgForm({super.key});

  @override
  State<AddOrgForm> createState() => _AddOrgFormState();
}

class _AddOrgFormState extends State<AddOrgForm> {
  final _formKey = GlobalKey<FormState>();

  User chief = User.empty();
  Organization organization = Organization.empty();

  Future<void> createOrg() async {

    await processDataSnack(
      context,
      () async {
        _formKey.currentState?.save();
        final response = await DioRequest.postRequest(
            'admin/createOrg', organization.toJson());
        final data = response.data;
        _formKey.currentState?.reset();
        return data;
      },
      successBuilder: (data) => 'Successful',
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
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
                        organization.director = chief;
                        await createOrg();
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
