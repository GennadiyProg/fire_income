import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fire_income/features/dio_request.dart';
import 'package:fire_income/features/form/login_form.dart';
import 'package:fire_income/features/process_data.dart';
import 'package:fire_income/features/widget/range_selector_text_form_field.dart';
import 'package:fire_income/models/Category.dart';
import 'package:fire_income/models/Product.dart';
import 'package:fire_income/models/Sale.dart';
import 'package:fire_income/models/User.dart';
import 'package:fire_income/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widget/amount_text_field.dart';

class AddSaleForm extends StatefulWidget {
  const AddSaleForm({super.key});

  @override
  State<AddSaleForm> createState() => _AddSaleFormState();
}

class _AddSaleFormState extends State<AddSaleForm> {
  final _formKey = GlobalKey<FormState>();
  Sale sale = Sale.empty();
  Category? category;
  Product? product;
  User? user;

  Future<void> createSale() async {
    await processDataSnack(
      context,
      () async {
        _formKey.currentState?.save();
        user = await loadUser(context);
        final DateTime time = DateTime.now();
        sale.product = product;
        sale.seller = user;
        sale.time = DateFormat("yyyy-MM-dd HH:mm:ss").format(time);
        final response =
            await DioRequest.postRequest('sale/create', sale.toJson());
        final data = response.data;
        _formKey.currentState?.reset();
        return data;
      },
      successBuilder: (data) => 'Добавлена продажа ${product?.name}',
    );
  }

  Future<List<Category>> getAllCategories() async {
    final response = await DioRequest.getRequest('category/', {});
    final data = response.data as List<dynamic>;
    final categories = data.map((e) => Category.fromJson(e)).toList();
    // if (category == null && categories.isNotEmpty) category = categories.first;
    return categories;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Создать продажу"),
      ),
      body: FutureBuilder(
        future: getAllCategories(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final categories = snapshot.data ?? [];
            return Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (categories.isNotEmpty) ...[
                      Text(
                        "Категория",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontSize: 18),
                      ),
                      DropdownButton2<Category>(
                        value: category,
                        hint: const Text("Выберите категорию"),
                        isExpanded: true,
                        onChanged: (newValue) {
                          setState(() {
                            if (newValue != null && newValue != category) {
                              product = null;
                              category = newValue;
                            }
                          });
                        },
                        items: categories
                            .map(
                              (e) => DropdownMenuItem<Category>(
                                value: e,
                                child: Text(e.name ?? e.id ?? ''),
                              ),
                            )
                            .toList(),
                      ),
                    ] else
                      Text(
                        "Для создания продажи добавьте категории",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: styles.dangerColor),
                      ),
                    const SizedBox(height: 20),
                    if (category != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: ProductDropdown(
                          categoryId: category?.id ?? '',
                          onChanged: (newProduct) {
                            setState(() {
                              product = newProduct;
                            });
                          },
                        ),
                      ),
                    if (category != null && product != null)
                      AmountTextField(
                        measureUnit: product?.measureUnit,
                        onChanged: (amount) {
                          setState(() {
                            sale.amount = amount;
                          });
                        },
                      ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ConstrainedBox(
                          constraints:
                              BoxConstraints.tight(const Size(200, 50)),
                          child: ElevatedButton(
                            onPressed: product != null
                                ? () async {
                                    await createSale();
                                  }
                                : null,
                            child: const Text('Submit'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          if (snapshot.hasError) {
            log(snapshot.error.toString(), stackTrace: snapshot.stackTrace);
            return Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text('Error: ${snapshot.error}'),
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class ProductDropdown extends StatefulWidget {
  final String categoryId;
  final void Function(Product?)? onChanged;

  const ProductDropdown({super.key, required this.categoryId, this.onChanged});

  @override
  State<ProductDropdown> createState() => _ProductDropdownState();
}

class _ProductDropdownState extends State<ProductDropdown> {
  Product? product;

  Future<List<Product>> getAllProducts() async {
    final response = await DioRequest.getRequest(
        'category/${widget.categoryId}/product', {});
    final data = response.data as List<dynamic>;
    return data.map((e) => Product.fromJson(e)).toList();
  }

  @override
  void didUpdateWidget(covariant ProductDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.categoryId != widget.categoryId) {
      product = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getAllProducts(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final products = snapshot.data ?? [];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Товар",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontSize: 18),
              ),
              products.isNotEmpty
                  ? DropdownButton2<Product>(
                      value: product,
                      hint: const Text("Выберите товар"),
                      isExpanded: true,
                      onChanged: (newValue) {
                        if (newValue != null) {
                          setState(() {
                            product = newValue;
                          });
                          widget.onChanged?.call(newValue);
                        }
                      },
                      items: products
                          .map(
                            (e) => DropdownMenuItem<Product>(
                              value: e,
                              child: Text(e.name ?? e.id ?? ''),
                            ),
                          )
                          .toList(),
                    )
                  : Text(
                      "В категории нет товаров",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: styles.dangerColor),
                    ),
            ],
          );
        }

        if (snapshot.hasError) {
          log(snapshot.error.toString(), stackTrace: snapshot.stackTrace);
          return Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text('Error: ${snapshot.error}'),
          );
        }

        return const CircularProgressIndicator();
      },
    );
  }
}
