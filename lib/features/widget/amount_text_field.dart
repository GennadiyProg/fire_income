import 'dart:ffi';

import 'dart:ffi';

import 'package:fire_income/models/Product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AmountTextField extends StatefulWidget {
  final String? measureUnit;
  final void Function(int?)? onChanged;

  const AmountTextField({super.key, this.measureUnit, this.onChanged});

  @override
  State<AmountTextField> createState() => _AmountTextFieldState();
}

class _AmountTextFieldState extends State<AmountTextField> {
  final amountController = TextEditingController(text: '1');

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Количество",
          style:
              Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 18),
        ),
        const SizedBox(width: 5),
        Expanded(
          child: TextFormField(
            controller: amountController,
            textAlign: TextAlign.center,
            textAlignVertical: TextAlignVertical.center,
            keyboardType: TextInputType.number,
            onChanged: (str) {
              setState(() {
                int amount = int.tryParse(amountController.text) ?? 0;
                widget.onChanged?.call(amount);
              });
            },
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(10),
            ],
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(12, 8, 8, 8),
              hintText: "4",
              isDense: true,
              isCollapsed: true,
              suffixText: widget.measureUnit,
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                int amount = int.tryParse(amountController.text) ?? 0;
                if (amount < 99) {
                  setState(() {
                    amount++;
                    amountController.text = amount.toString();
                    widget.onChanged?.call(amount);
                  });
                }
              },
              icon: const Icon(Icons.add_rounded),
              padding: EdgeInsets.zero,
              iconSize: 30,
              visualDensity: VisualDensity.compact,
              constraints: const BoxConstraints(
                minHeight: 30,
                minWidth: 30,
                maxHeight: 30,
                maxWidth: 30,
              ),
            ),
            IconButton(
              onPressed: () {
                int amount = int.tryParse(amountController.text) ?? 2;
                if (amount > 1) {
                  setState(() {
                    amount--;
                    amountController.text = amount.toString();
                    widget.onChanged?.call(amount);
                  });
                }
              },
              icon: const Icon(Icons.remove_rounded),
              padding: EdgeInsets.zero,
              iconSize: 30,
              visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
              constraints: const BoxConstraints(
                minHeight: 30,
                minWidth: 30,
                maxHeight: 30,
                maxWidth: 30,
              ),
            ),
          ],
        )
      ],
    );
  }
}
