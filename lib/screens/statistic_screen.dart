import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fire_income/features/dio_request.dart';
import 'package:fire_income/features/form/login_form.dart';
import 'package:fire_income/features/process_data.dart';
import 'package:fire_income/features/widget/range_selector_text_form_field.dart';
import 'package:fire_income/models/Category.dart';
import 'package:fire_income/models/Product.dart';
import 'package:fire_income/models/Sale.dart';
import 'package:fire_income/models/Statistic.dart';
import 'package:fire_income/models/User.dart';
import 'package:fire_income/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StatisticScreen extends StatefulWidget {
  const StatisticScreen({super.key});

  @override
  State<StatisticScreen> createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<StatisticScreen> {
  Sale sale = Sale.empty();

  Future<Map<String?, int>?> getStatistic() async {
    log(chosenAddress);
    if (chosenAddress.isEmpty) return <String?, int>{};
    final response = await DioRequest.getRequest(chosenAddress, {});
    final data = response.data as List<dynamic>;
    print(data);
    final list = data.map((e) => Statistic.fromJson(e)).toList()
      ..sort((b, a) => a.count?.compareTo(b.count ?? 0) ?? 0);
    switch (chosenAddress) {
      case 'chief/statistic/category':
        return Map.fromEntries(
            list.map((e) => MapEntry(e.category?.name, e.count ?? 0)));
      case 'chief/statistic/branch':
        return Map.fromEntries(
            list.map((e) => MapEntry(e.branch?.kpp, e.count ?? 0)));
      case 'chief/statistic/time':
        return Map.fromEntries(list.map((e) => MapEntry(
            DateFormat.yMMMM().format(e.date ?? DateTime.now()), e.count ?? 0)));
    }
    return <String?, int>{};
  }

  List<String> statisticEndpoints = [
    'chief/statistic/category',
    'chief/statistic/branch',
    'chief/statistic/time',
  ];

  String chosenAddress = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          initialData: const <String?, int>{},
          future: getStatistic(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final statistic = snapshot.data ?? {};
              return SingleChildScrollView(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Статистика по",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontSize: 18),
                    ),
                    const SizedBox(height: 5),
                    Wrap(
                      spacing: 5.0,
                      children: [
                        ChoiceChip(
                          label: const Text('Категория'),
                          selected: chosenAddress == statisticEndpoints[0],
                          onSelected: (bool selected) {
                            if (selected) {
                              setState(() {
                                chosenAddress = statisticEndpoints[0];
                              });
                            }
                          },
                        ),
                        ChoiceChip(
                          label: const Text('Филиал'),
                          selected: chosenAddress == statisticEndpoints[1],
                          onSelected: (bool selected) {
                            if (selected) {
                              setState(() {
                                chosenAddress = statisticEndpoints[1];
                              });
                            }
                          },
                        ),
                        ChoiceChip(
                          label: const Text('Время'),
                          selected: chosenAddress == statisticEndpoints[2],
                          onSelected: (bool selected) {
                            if (selected) {
                              setState(() {
                                chosenAddress = statisticEndpoints[2];
                              });
                            }
                          },
                        ),
                      ],
                    ),
                    if (statistic.isNotEmpty) ...[
                      Flexible(
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final item = statistic.keys.toList()[index];
                            return ListTile(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(item ?? ''),
                                  Text(statistic[item].toString())
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => const Divider(),
                          itemCount: statistic.length,
                          physics: const NeverScrollableScrollPhysics(),
                        ),
                      ),
                    ] else
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(top: 20),
                        child: const Text("Статистики не найдено"),
                      ),
                  ],
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
      ),
    );
  }
}
