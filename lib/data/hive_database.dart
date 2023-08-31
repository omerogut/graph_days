import 'package:hive_flutter/hive_flutter.dart';
import 'package:graph_days/models/expense_item.dart';

class HiveDatabase{
  //reference our box
  final _myBox = Hive.box("expense_database");

  //write data
  void saveData(List<ExpenseItem> allExpense){
/*
hive can only store strings and datetime, and not custom objects
like ExpensesItem. So lets convert ExpenseItem into types that
can be stored in our db.

allExpense=
[
ExpenseItem (name / amount / dateTime)
]

->
[name, amount, dateTime]
..

*/
  List<List<dynamic>> allExpensesFormated =[];

  for (var expense in allExpense){

    //convert each expenseItem into a list of storable types (string, dateTime)

    List<dynamic> expenseFormatted=[
      expense.name,
      expense.amount,
      expense.dateTime,
    ];
    allExpensesFormated.add(expenseFormatted);
  }

  //finally lets store in our database
    _myBox.put("ALL_EXPENSES", allExpensesFormated);
  }
  //read data
List<ExpenseItem> readData(){
    /*
    Data is storedin Hive as a list of strings + dateTime
    so lets convert our saved data into ExpenseItem objects

    savedData=

    [name, amount, dateTime]

    ExpenseItem (name / amount/ dateTime),

    */

  List savedExpenses = _myBox.get("ALL_EXPENSES") ?? [];
  List<ExpenseItem> allExpenses = [];

  for (int i = 0; i < savedExpenses.length; i++){
    //collect individual expense data
    String name = savedExpenses[i][0];
    String amount = savedExpenses[i][1];
    DateTime dateTime = savedExpenses[i][2];

    //create expense item
    ExpenseItem expense = ExpenseItem(
        name: name,
        amount: amount,
        dateTime: dateTime,
    );
    //add expense to overall list of expenses
    allExpenses.add(expense);

  }
  return allExpenses;
}

}