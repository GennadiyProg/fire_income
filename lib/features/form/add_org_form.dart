import 'package:dio/dio.dart';
import 'package:fire_income/models/Organization.dart';
import 'package:fire_income/models/User.dart';
import 'package:flutter/material.dart';

class AddOrg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    User chief = User.empty();
    Organization organization = Organization.empty();

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 50, 10, 10),
        child: SingleChildScrollView(
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
                labelText: "Название организации",
                valueSetter: (value) => organization.name = value,
              ),
              const SizedBox(height: 20),
              RangeSelectorTextFormField(
                labelText: "ИНН",
                valueSetter: (value) => organization.inn = value,
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
                        final response = await Dio().post(
                            'http://192.168.0.10:8080/admin/createOrg',
                            data: organization.toJson(),
                            options: Options(
                                contentType: Headers.jsonContentType
                            ));
                        final data = response.data;
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
      ),
    );
  }
}

class RangeSelectorTextFormField extends StatelessWidget {
  final String labelText;
  final void Function(String value) valueSetter;

  RangeSelectorTextFormField(
      {Key? key, required this.labelText, required this.valueSetter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: labelText,
      ),
      onSaved: (newValue) => valueSetter(newValue ?? ''),
    );
  }
}
