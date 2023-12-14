import 'package:flutter/material.dart';

import '../../styles/styles.dart';

void showSnackBar(BuildContext context, String text, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      backgroundColor: color,
    ),
  );
}

void showDeleteSnackBar(BuildContext context, {String? text, Color? color}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text ?? "Успешно удалено"),
      backgroundColor: color ?? styles.successColor,
    ),
  );
}

void showErrorSnackBar(BuildContext context, Object error, {Color? color}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(error.toString()),
      backgroundColor: color ?? styles.dangerColor,
    ),
  );
}
