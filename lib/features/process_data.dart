import 'dart:async';
import 'dart:developer';

import 'package:fire_income/styles/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> processDataSnack<T>(
    BuildContext context, FutureOr<T> Function() callback,
    {String Function(T data)? successBuilder}) async {
  try {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Processing Data')),
    );

    final T res = await callback();

    if (res != null && context.mounted) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(successBuilder?.call(res) ?? "Данные обновлены"),
          backgroundColor: styles.successColor,
        ),
      );
    }

    print(res.toString());
  } catch (e, s) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: styles.dangerColor,
        ),
      );
    }
    log("Error", error: e, stackTrace: s);
  }
}
