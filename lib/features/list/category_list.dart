import 'dart:developer';

import 'package:fire_income/features/dio_request.dart';
import 'package:fire_income/features/form/add_category_form.dart';
import 'package:fire_income/features/widget/show_snack_bar.dart';
import 'package:fire_income/models/Category.dart';
import 'package:fire_income/styles/styles.dart';
import 'package:flutter/material.dart';

import 'product_list.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {

  Future<List<Category>> getAllCategories() async {
    final response = await DioRequest.getRequest('category/', {});
    final data = response.data as List<dynamic>;
    print(data);
    return data.map((e) => Category.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddCategoryForm()),
          ).then((value) => setState(() {}));
        },
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: FutureBuilder(
          future: getAllCategories(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final categories = snapshot.data ?? [];
              return categories.isNotEmpty
                  ? ListView.separated(
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        return ListTile(
                          title: Text(category.name ?? ''),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductList(category)),
                            ).then((value) => setState(() {}));
                          },
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(),
                    )
                  : const Text("Категории не найдены");
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
