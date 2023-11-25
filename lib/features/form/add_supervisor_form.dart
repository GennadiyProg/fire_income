import 'package:fire_income/features/dio_request.dart';
import 'package:fire_income/features/widget/range_selector_text_form_field.dart';
import 'package:fire_income/models/User.dart';
import 'package:flutter/material.dart';

class AddSupervisorForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    User user = User.empty();

    Future<String> createSupervisor() async {
      final response = await DioRequest.postRequest('chief/supervisors/create', user.toJson());
      final data = response.data;
      print(data);
      return data;
    }

    void goPrev(value) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Добавлен новый пользователь $value')),
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
                        createSupervisor().then((value) => goPrev(value));
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
