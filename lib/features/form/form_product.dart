import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/Product.dart';

class FormProduct extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    Product product = Product();

    return Form(
      key: _formKey,
      onChanged: () {
        // Form.of(primaryFocus!.context!).save();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(children: <Widget>[
              const Text("Название"),
              ConstrainedBox(
                constraints: BoxConstraints.tight(const Size(200, 50)),
                child: TextFormField(
                  onSaved: (String? value) {
                    product.name = value;
                  },
                ),
              ),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(children: <Widget>[
              const Text("Категория"),
              ConstrainedBox(
                constraints: BoxConstraints.tight(const Size(200, 50)),
                child: TextFormField(
                  onSaved: (String? value) {
                    product.category = value;
                  },
                ),
              ),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(children: <Widget>[
              const Text("Единица измерения"),
              ConstrainedBox(
                constraints: BoxConstraints.tight(const Size(200, 50)),
                child: TextFormField(
                  onSaved: (String? value) {
                    product.measureUnit = value;
                  },
                ),
              ),
            ]),
          ),
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
                    final response = await Dio().post(
                        'http://localhost:8080/product/',
                        data: product.toJson(),
                        options: Options(
                            contentType: Headers.jsonContentType
                        ));
                    final data = response.data as Map<String, dynamic>;
                    print(data.toString());
                  },
                  child: const Text('Submit'),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}