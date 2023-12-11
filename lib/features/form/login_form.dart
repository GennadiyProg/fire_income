import 'dart:convert';
import 'dart:developer';

import 'package:fire_income/features/dio_request.dart';
import 'package:fire_income/features/widget/range_selector_text_form_field.dart';
import 'package:fire_income/models/User.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  Future<User?> loadUser(context) async {
    try {
      final response = await DioRequest.getRequest('loadUser', {});
      User user = User.fromJson(response.data);
      print(user);
      return user;
    } catch (e) {
      log('$e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("$e")),
      );
    }
    return null;
  }

  void selectRoute(BuildContext context, var userRole) {
    ScaffoldMessenger.of(context).clearSnackBars();
    if (userRole == "ADMIN") {
      Navigator.pushNamedAndRemoveUntil(context, '/admin', (route) => false);
    } else if (userRole == "CHIEF") {
      Navigator.pushNamedAndRemoveUntil(context, '/chief', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String username = '';
    String password = '';

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 50, 10, 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RangeSelectorTextFormField(
                labelText: "Username",
                valueSetter: (value) => username = value,
              ),
              const SizedBox(height: 20),
              RangeSelectorTextFormField(
                labelText: "Пароль",
                valueSetter: (value) => password = value,
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
                        DioRequest.token =
                            base64Encode(utf8.encode('$username:$password'));
                        final user = await loadUser(context);
                        if (context.mounted && user != null) {
                          selectRoute(context, user.role);
                        }
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
