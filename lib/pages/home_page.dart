import 'package:flutter/material.dart';
import 'package:graph_days/components/expense_tile.dart';
import 'package:graph_days/data/expense_data.dart';
import 'package:graph_days/models/expense_item.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //text controllers
  final newExpenseNameController = TextEditingController();
  final newExpenseAmountController = TextEditingController();

  void addNewExpense() {
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: Text('Add new expense'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //expense name
                TextField(
                  controller: newExpenseNameController,
                ),
                //expense amount
                TextField(
                  controller: newExpenseAmountController,
                ),
              ],
            ),
            actions: [
              //save buttons
              MaterialButton(
                onPressed: save,
                child: Text('Save'),
              ),
              //cancel button
              MaterialButton(
                onPressed: cancel,
                child: Text('Cancel'),
              )
            ],
          ),
    );
  }

  void save() {
    //create expense item
    ExpenseItem newExpense = ExpenseItem(name: newExpenseNameController.text,
      amount: newExpenseAmountController.text,
      dateTime: DateTime.now(),
    );
    //add the new expense
    Provider.of<ExpensesData>(context, listen: false).addNewExpense(newExpense);

    Navigator.pop(context);
    clear();
  }

  void cancel() {
    Navigator.pop(context);
    clear();
  }
//clear controllers
  void clear() {
    newExpenseNameController.clear();
    newExpenseAmountController.clear();
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<ExpensesData>(
      builder: (context, value, child) =>
          Scaffold(
            backgroundColor: Colors.blueGrey,
            floatingActionButton: FloatingActionButton(
              onPressed: addNewExpense,
              child: Icon(Icons.add),
            ),
            body: ListView(children:[
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: value.getAllExpenseList().length,
              itemBuilder: (context, index) => ExpenseTile(
                  name: value.getAllExpenseList()[index].name,
                  amount: value.getAllExpenseList()[index].amount,
                  dateTime: value.getAllExpenseList()[index].dateTime,
              ),
              ),
      ]),
            ),
          );

  }
}



