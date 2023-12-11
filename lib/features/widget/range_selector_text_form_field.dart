import 'package:flutter/material.dart';

class RangeSelectorTextFormField extends StatelessWidget {
  final String labelText;
  final void Function(String value) valueSetter;
  final TextInputAction? textInputAction;

  const RangeSelectorTextFormField(
      {Key? key,
      required this.labelText,
      required this.valueSetter,
      this.textInputAction = TextInputAction.next})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: labelText,
      ),
      onSaved: (newValue) => valueSetter(newValue ?? ''),
      textInputAction: textInputAction,
    );
  }
}
