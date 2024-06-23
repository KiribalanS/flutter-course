import 'package:expense_tracker/model.dart';
import 'package:flutter/material.dart';

class Expenses extends StatelessWidget {
  const Expenses({
    required this.expense,
    required this.removeExpense,
    super.key,
  });
  final void Function(ExpenseModel exp) removeExpense;
  final List<ExpenseModel> expense;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) => Card(
        child: Dismissible(
          background: Card(
            color: Theme.of(context).cardColor,
          ),
          key: ValueKey(expense[index]),
          onDismissed: (direction) => removeExpense(expense[index]),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  cateogoryIcons[expense[index].category] ?? '🤷🏽‍♂️',
                  style: const TextStyle(
                    fontSize: 25,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Rs.  ${expense[index].amount}"),
                    Text(expense[index].title),
                  ],
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 18.0),
                  child: Text(expense[index].formatedDate),
                ),
              ],
            ),
          ),
        ),
      ),
      itemCount: expense.length,
    );
  }
}
