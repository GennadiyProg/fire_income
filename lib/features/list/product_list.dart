import 'dart:developer';

import 'package:fire_income/features/dio_request.dart';
import 'package:fire_income/features/form/add_category_form.dart';
import 'package:fire_income/features/form/add_product_form.dart';
import 'package:fire_income/features/widget/show_snack_bar.dart';
import 'package:fire_income/models/Category.dart';
import 'package:fire_income/models/Product.dart';
import 'package:fire_income/styles/styles.dart';
import 'package:flutter/material.dart';

class ProductList extends StatefulWidget {
  final Category category;

  const ProductList(this.category, {super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  Future<List<Product>> getAllProducts() async {
    final response = await DioRequest.getRequest(
        'category/${widget.category.id}/product', {});
    final data = response.data as List<dynamic>;
    print(data);
    return data.map((e) => Product.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.category.name ?? '')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddProductForm(widget.category.id ?? '')),
          ).then((value) => setState(() {}));
        },
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: FutureBuilder(
          future: getAllProducts(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final products = snapshot.data ?? [];
              return products.isNotEmpty
                  ? ListView.separated(
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return ListTile(
                          title: Text(product.name ?? ''),
                          onTap: () {
                            log("${product.name} ${product.category?.name} ${product.measureUnit}");
                            /*Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddSellerForm(
                                    widget.kpp,
                                  )),
                            ).then((value) => setState((){}));*/
                          },
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(),
                    )
                  : const Text("Товары не найдены");
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
        ),
      ),
    );
  }
}
