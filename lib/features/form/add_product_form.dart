import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fire_income/features/dio_request.dart';
import 'package:fire_income/features/process_data.dart';
import 'package:fire_income/features/widget/range_selector_text_form_field.dart';
import 'package:fire_income/models/Category.dart';
import 'package:fire_income/models/Product.dart';
import 'package:fire_income/models/User.dart';
import 'package:fire_income/styles/styles.dart';
import 'package:flutter/material.dart';

class AddProductForm extends StatefulWidget {
  final String categoryId;

  const AddProductForm(this.categoryId, {super.key});

  @override
  State<AddProductForm> createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm> {
  final _formKey = GlobalKey<FormState>();
  Product product = Product.empty();
  MeasureUnit measureUnit = MeasureUnit.KG;

  Future<void> createProduct() async {
    await processDataSnack(
      context,
      () async {
        product.measureUnit = measureUnit.name;
        _formKey.currentState?.save();
        final response = await DioRequest.postRequest(
            'category/${widget.categoryId}/product', product.toJson());
        final data = response.data;
        _formKey.currentState?.reset();
        return data;
      },
      successBuilder: (data) =>
          'Добавлен новый продукт ${Product.fromJson(data).name}',
    );

    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Добавить товар"),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              RangeSelectorTextFormField(
                labelText: "Название",
                valueSetter: (value) => product.name = value,
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Wrap(
                  spacing: 10,
                  runSpacing: 5,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      "Единицы измерения:",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    DropdownButton2<MeasureUnit>(
                      value: measureUnit,
                      isExpanded: true,
                      alignment: Alignment.centerLeft,
                      buttonStyleData: const ButtonStyleData(
                        padding: EdgeInsets.zero,
                        width: 80,
                      ),
                      onChanged: (newValue) {
                        setState(() {
                          if (newValue != null) {
                            measureUnit = newValue;
                          }
                        });
                      },
                      items: MeasureUnit.values
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(e.name),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(children: <Widget>[
                  ConstrainedBox(
                    constraints: BoxConstraints.tight(const Size(200, 50)),
                    child: ElevatedButton(
                      onPressed: () async {
                        await createProduct();
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
