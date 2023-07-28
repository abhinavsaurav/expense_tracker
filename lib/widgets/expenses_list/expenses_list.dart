import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  final List<Expense> expenses;
  final void Function(Expense item) removeItem;
  const ExpensesList(
      {super.key, required this.expenses, required this.removeItem});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expenses.length,
        // shrinkWrap: true,
        // physics: ClampingScrollPhysics(),
        itemBuilder: (ctx, index) {
          return Dismissible(
            key: ValueKey(expenses[index]),
            onDismissed: (direction) {
              removeItem(expenses[index]);
            },
            background: Container(
              color: Theme.of(context).colorScheme.error.withOpacity(0.75),
              // The margin is !
              margin: EdgeInsets.symmetric(
                horizontal: Theme.of(context).cardTheme.margin!.horizontal,
              ),
            ),
            child: ExpenseItem(
              expense: expenses[index],
            ),
          );
          // return ExpenseItem(
          //   expense: expenses[index],
          // );
        });
  }
}


//  Dismissible(
//         key: ValueKey(expenses[index]),
//         onDismissed: (direction) {
//           removeItem(expenses[index]);
//         },
//         background: Container(
//           color: Theme.of(context).colorScheme.error.withOpacity(0.75),
//           // The margin is !
//           margin: EdgeInsets.symmetric(
//             horizontal: Theme.of(context).cardTheme.margin!.horizontal,
//           ),
//         ),
//         child: ExpenseItem(
//           expense: expenses[index],
//         ),
//       ),