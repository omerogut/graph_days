import 'package:flutter/material.dart';
import 'package:graph_days/components/expense_sumary.dart';
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
  final newExpenseDollarController = TextEditingController();
  final newExpenseCentsController = TextEditingController();

  void initState(){
    //TODO : imğlement initState
    super.initState();
    //prepare data on startup
    Provider.of<ExpensesData>(context, listen: false).prepareData();
  }

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
                  decoration: const InputDecoration(
                    hintText: "Expense name",
                  ),
                ),
                //expense amount
                Row(children: [
                  //dollars
                  Expanded(
                    child: TextField(
                      controller: newExpenseDollarController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: "Dollars",
                      ),
                    ),
                  ),

                  //cents
                  Expanded(
                    child: TextField(
                      controller: newExpenseCentsController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: "Cents",
                      ),
                    ),
                  ),
                ],
                ),
              ],
            ),
            actions: [
              //save buttons
              MaterialButton(
                onPressed: cancel,
                child: Text('Cancel'),
              ),
              //cancel button
              MaterialButton(
                onPressed: save,
                child: Text('Save'),
              )
            ],
          ),
    );
  }

  void deleteExpense(ExpenseItem expense){
    Provider.of<ExpensesData>(context, listen: false).deleteExpense(expense);
  }

  void save() {
    //putting dolars and cents in the amount
    String amount= '${newExpenseDollarController.text}.${newExpenseCentsController.text}';


    //create expense item
    ExpenseItem newExpense = ExpenseItem(
      name: newExpenseNameController.text,
      amount: amount,
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
    newExpenseDollarController.clear();
    newExpenseCentsController.clear();
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<ExpensesData>(
      builder: (context, value, child) =>
          Scaffold(
            backgroundColor: Colors.blueGrey,
            floatingActionButton: FloatingActionButton(
              onPressed: addNewExpense,
              backgroundColor: Colors.black,
              child: const Icon(Icons.add),
            ),
            body: ListView(children:[
              //weekly sumary
              ExpenseSumary(startOfWeek: value.startOfWeekDate()),

              const SizedBox(height: 20,),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: value.getAllExpenseList().length,
              itemBuilder: (context, index) => ExpenseTile(
                  name: value.getAllExpenseList()[index].name,
                  amount: value.getAllExpenseList()[index].amount,
                  dateTime: value.getAllExpenseList()[index].dateTime,
                  deleteTapped: (p0)=>deleteExpense(value.getAllExpenseList()[index]),
              ),
              ),
      ]),
            ),
          );

  }
}



