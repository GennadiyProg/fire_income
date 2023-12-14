import 'package:fire_income/features/dio_request.dart';
import 'package:fire_income/features/process_data.dart';
import 'package:fire_income/features/widget/range_selector_text_form_field.dart';
import 'package:fire_income/models/Category.dart';
import 'package:fire_income/models/User.dart';
import 'package:fire_income/styles/styles.dart';
import 'package:flutter/material.dart';

class AddCategoryForm extends StatefulWidget {
  const AddCategoryForm({super.key});

  @override
  State<AddCategoryForm> createState() => _AddCategoryFormState();
}

class _AddCategoryFormState extends State<AddCategoryForm> {
  final _formKey = GlobalKey<FormState>();
  Category category = Category.empty();

  Future<void> createCategory() async {
    await processDataSnack(
      context,
      () async {
        _formKey.currentState?.save();
        final response =
            await DioRequest.postRequest('category/create', category.toJson());
        final data = response.data;
        _formKey.currentState?.reset();
        return data;
      },
      successBuilder: (data) => 'Добавлена новая категория ${Category.fromJson(data).name}',
    );

    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Добавить категорию"),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RangeSelectorTextFormField(
                labelText: "Название",
                valueSetter: (value) => category.name = value,
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
                        await createCategory();
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
