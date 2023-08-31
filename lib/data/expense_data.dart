import 'package:flutter/cupertino.dart';
import 'package:graph_days/data/hive_database.dart';
import 'package:graph_days/datetime/date_time_helper.dart';
import 'package:graph_days/models/expense_item.dart';

class ExpensesData extends ChangeNotifier{
//list of all expenses
List<ExpenseItem> overallExpenseList=[];

//get expense list
List<ExpenseItem> getAllExpenseList(){
  return overallExpenseList;
}
//prepare data to display

  final db= HiveDatabase();
  void prepareData(){
  // if there exists data get it
    if(db.readData().isNotEmpty){
      overallExpenseList= db.readData();
    }
  }

//add new expense
void addNewExpense(ExpenseItem newExpense){
  overallExpenseList.add(newExpense);
  notifyListeners();
  db.saveData(overallExpenseList);

}
//delete expense
void deleteExpense(ExpenseItem expense){
  overallExpenseList.remove(expense);
  notifyListeners();
  db.saveData(overallExpenseList);

}
//get weekday
String getDayName(DateTime dateTime){
  switch(dateTime.weekday){
    case 1:
      return 'Mon';
    case 2:
      return 'Tue';
    case 3:
      return 'Wed';
    case 4:
      return 'Thi';
    case 5:
      return 'Fri';
    case 6:
      return 'Sat';
    case 7:
      return 'Sun';
      break;
    default:
      return '';
  }
}
//get the date for the start of the week
DateTime startOfWeekDate(){
  DateTime? startOfWeek;

//get todays date
DateTime today = DateTime.now();

//go backwards from today to find sunday
for(int i = 0; i<7; i++){
  startOfWeek = today.subtract(Duration(days: i));
  }


return startOfWeek!;
}

Map<String, double> calculateDailyExpenseSumary(){
  Map<String, double> dailyExpenseSumary= {
   //date
  };
  for (var expense in overallExpenseList){
    String date = convertDateTimeToString(expense.dateTime);
    double amount = double.parse(expense.amount);

    if(dailyExpenseSumary.containsKey(date)){
      double currentAmount = dailyExpenseSumary[date]!;
      currentAmount += amount;
      dailyExpenseSumary[date] = currentAmount;
    }else{
      dailyExpenseSumary.addAll({date: amount});
  }
  }

  return dailyExpenseSumary;
}
}