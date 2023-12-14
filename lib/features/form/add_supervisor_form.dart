import 'package:fire_income/features/dio_request.dart';
import 'package:fire_income/features/process_data.dart';
import 'package:fire_income/features/widget/range_selector_text_form_field.dart';
import 'package:fire_income/models/User.dart';
import 'package:fire_income/styles/styles.dart';
import 'package:flutter/material.dart';

class AddSupervisorForm extends StatefulWidget {
  const AddSupervisorForm({super.key});

  @override
  State<AddSupervisorForm> createState() => _AddSupervisorFormState();
}

class _AddSupervisorFormState extends State<AddSupervisorForm> {
  final _formKey = GlobalKey<FormState>();
  User user = User.empty();

  Future<void> createSupervisor() async {
    await processDataSnack(
      context,
      () async {
        _formKey.currentState?.save();
        final response = await DioRequest.postRequest(
            'chief/supervisors/create', user.toJson());
        final data = response.data;
        _formKey.currentState?.reset();
        return data;
      },
      successBuilder: (data) => 'Добавлен новый пользователь $data',
    );

    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Добавить супервайзера"),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RangeSelectorTextFormField(
                labelText: "Фамилия",
                valueSetter: (value) => user.surname = value,
              ),
              const SizedBox(height: 20),
              RangeSelectorTextFormField(
                labelText: "Имя",
                valueSetter: (value) => user.firstName = value,
              ),
              const SizedBox(height: 20),
              RangeSelectorTextFormField(
                labelText: "Отчество",
                valueSetter: (value) => user.lastName = value,
              ),
              const SizedBox(height: 20),
              RangeSelectorTextFormField(
                labelText: "Паспорт",
                valueSetter: (value) => user.passport = value,
              ),
              const SizedBox(height: 20),
              RangeSelectorTextFormField(
                labelText: "Пароль",
                valueSetter: (value) => user.password = value,
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
                        await createSupervisor();
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
