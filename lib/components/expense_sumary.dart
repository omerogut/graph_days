import 'package:flutter/material.dart';
import 'package:graph_days/bar_graph/bar_graph.dart';
import 'package:graph_days/data/expense_data.dart';
import 'package:graph_days/datetime/date_time_helper.dart';
import 'package:provider/provider.dart';

class ExpenseSumary extends StatelessWidget {
  final DateTime startOfWeek;

  const ExpenseSumary({
    super.key,
    required this.startOfWeek,
  });

  @override
  Widget build(BuildContext context) {
    //get yyyymmdd for each of this week
    String monday = convertDateTimeToString(startOfWeek.add(Duration(days: 0)));
    String tuesday = convertDateTimeToString(startOfWeek.add(Duration(days: 1)));
    String wednesday = convertDateTimeToString(startOfWeek.add(Duration(days: 2)));
    String thursday = convertDateTimeToString(startOfWeek.add(Duration(days: 3)));
    String friday = convertDateTimeToString(startOfWeek.add(Duration(days: 4)));
    String saturday = convertDateTimeToString(startOfWeek.add(Duration(days: 5)));
    String sunday = convertDateTimeToString(startOfWeek.add(Duration(days: 6)));

    return Consumer<ExpensesData>(
        builder: (context, value, child) => SizedBox(
              height: 200,
              child: MyBarGraph(
                maxY: 100,
                monAmount: value.calculateDailyExpenseSumary()[monday] ?? 0,
                tueAmount: value.calculateDailyExpenseSumary()[tuesday] ?? 0,
                wedAmount: value.calculateDailyExpenseSumary()[wednesday] ?? 0,
                thiAmount: value.calculateDailyExpenseSumary()[thursday] ?? 0,
                friAmount: value.calculateDailyExpenseSumary()[friday] ?? 0,
                satAmount: value.calculateDailyExpenseSumary()[saturday] ?? 0,
                sunAmount: value.calculateDailyExpenseSumary()[sunday] ?? 0,
              ),
            ));
  }
}
