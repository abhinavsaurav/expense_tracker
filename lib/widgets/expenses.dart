import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpense = [
    Expense(
      title: "flutter dummy1",
      amount: 20.0,
      date: DateTime.now(),
      category: Category.food,
    ),
    Expense(
      title: "flutter dummy2",
      amount: 60,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: "flutter dummy3",
      amount: 23.0,
      date: DateTime.now(),
      category: Category.travel,
    ),
    Expense(
      title: "flutter dummy4",
      amount: 50.0,
      date: DateTime.now(),
      category: Category.leisure,
    ),
    Expense(
      title: "flutter dummy5",
      amount: 50.0,
      date: DateTime.now(),
      category: Category.work,
    ),
  ];

  void _addToExpenseList(Expense item) {
    setState(() {
      _registeredExpense.add(item);
    });
  }

  void _removeExpenseItem(Expense item) {
    int removeItemIndex = _registeredExpense.indexOf(item);
    setState(() {
      _registeredExpense.remove(item);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 3),
      content: const Text("Item deleted"),
      action: SnackBarAction(
        label: "Undo",
        onPressed: () {
          setState(() {
            _registeredExpense.insert(removeItemIndex, item);
          });
        },
      ),
    ));
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      constraints: const BoxConstraints(minWidth: double.infinity),
      builder: (context) => NewExpense(_addToExpenseList),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text("No item available to display!"),
    );

    var width = MediaQuery.of(context).size.width;

    if (_registeredExpense.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpense,
        removeItem: _removeExpenseItem,
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text("Expense Tracker"),
          actions: [
            // actions wants a list of widgets
            IconButton(
                onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add)),
          ],
        ),
        body: width < 600
            ? Column(
                children: [
                  Chart(expenses: _registeredExpense),
                  Expanded(
                    child: mainContent,
                  ),
                ],
              )
            : Row(
                children: [
                  Expanded(child: Chart(expenses: _registeredExpense)),
                  Expanded(
                    child: mainContent,
                  ),
                ],
              ));
  }
}
