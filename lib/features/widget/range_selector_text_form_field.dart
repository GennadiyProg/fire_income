import 'package:flutter/material.dart';

class RangeSelectorTextFormField extends StatelessWidget {
  final String labelText;
  final void Function(String value) valueSetter;

  RangeSelectorTextFormField(
      {Key? key, required this.labelText, required this.valueSetter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: labelText,
      ),
      onSaved: (newValue) => valueSetter(newValue ?? ''),
    );
  }
}