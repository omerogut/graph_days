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
  //calculate
  double calculateMax(
      ExpensesData value,
      String monday,
      String tuesday,
      String wednesday,
      String thursday,
      String friday,
      String saturday,
      String sunday,
      ){
    double? max = 100;

    List<double> values = [
      value.calculateDailyExpenseSumary()[monday] ?? 0,
      value.calculateDailyExpenseSumary()[tuesday] ?? 0,
      value.calculateDailyExpenseSumary()[wednesday] ?? 0,
      value.calculateDailyExpenseSumary()[thursday] ?? 0,
      value.calculateDailyExpenseSumary()[friday] ?? 0,
      value.calculateDailyExpenseSumary()[saturday] ?? 0,
      value.calculateDailyExpenseSumary()[sunday] ?? 0,
    ];
    //sort from smallest to largest
    values.sort();
    //get largest amount
    //and increase the cap slightly so the graph looks almost full
    max = values.last * 1.1;

    return max == 0 ? 100: max;
  }
  //calculate the week
String calculateWeekTotal(
    ExpensesData value,
    String monday,
    String tuesday,
    String wednesday,
    String thursday,
    String friday,
    String saturday,
    String sunday,
    )
{
  List<double> values = [
  value.calculateDailyExpenseSumary()[monday] ?? 0,
  value.calculateDailyExpenseSumary()[tuesday] ?? 0,
  value.calculateDailyExpenseSumary()[wednesday] ?? 0,
  value.calculateDailyExpenseSumary()[thursday] ?? 0,
  value.calculateDailyExpenseSumary()[friday] ?? 0,
  value.calculateDailyExpenseSumary()[saturday] ?? 0,
  value.calculateDailyExpenseSumary()[sunday] ?? 0,
  ];
  double total = 0;
  for (int i = 0; i <values.length; i++){
    total += values[i];
  }
  return total.toStringAsFixed(2);

  }

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
        builder: (context, value, child) => Column(
          children: [
            //week total
            Padding(padding: const EdgeInsets.all(25.0),
            child: Row(
              children: [
                const Text(
                  'Week Total: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                    '\$${calculateWeekTotal(value, monday, tuesday,
                    wednesday, thursday, friday, saturday, sunday)}'
                ),
              ],
            ),
            ),

            SizedBox(
                  height: 200,
                  child: MyBarGraph(
                    maxY: calculateMax(value, monday, tuesday, wednesday, thursday, friday, saturday, sunday),
                    monAmount: value.calculateDailyExpenseSumary()[monday] ?? 0,
                    tueAmount: value.calculateDailyExpenseSumary()[tuesday] ?? 0,
                    wedAmount: value.calculateDailyExpenseSumary()[wednesday] ?? 0,
                    thiAmount: value.calculateDailyExpenseSumary()[thursday] ?? 0,
                    friAmount: value.calculateDailyExpenseSumary()[friday] ?? 0,
                    satAmount: value.calculateDailyExpenseSumary()[saturday] ?? 0,
                    sunAmount: value.calculateDailyExpenseSumary()[sunday] ?? 0,
                  ),
                ),
          ],
        ),
    );
  }
}
