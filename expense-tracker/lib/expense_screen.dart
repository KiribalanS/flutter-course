import 'package:expense_tracker/add_new_expense.dart';
import 'package:expense_tracker/chart.dart';
import 'package:expense_tracker/dummy.dart';
import 'package:expense_tracker/expenses.dart';
import 'package:expense_tracker/model.dart';
import 'package:flutter/material.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  void buildModalSheet() {
    showModalBottomSheet(
      useSafeArea: true,
      enableDrag: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => AddNewExpense((ExpenseModel exp) {
        setState(() {
          dummy.add(exp);
        });
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    var children = [
      Expanded(
        child: Chart(expenses: dummy),
      ),
      Expanded(
        child: Expenses(
          expense: dummy,
          removeExpense: (ExpenseModel exp) {
            final index = dummy.indexOf(exp);
            setState(() {
              dummy.remove(exp);
            });

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                action: SnackBarAction(
                  label: "Retrieve",
                  onPressed: () {
                    setState(() {
                      dummy.insert(index, exp);
                    });
                  },
                ),
                duration: const Duration(seconds: 2),
                content: const Text("Expense removed!"),
              ),
            );
          },
        ),
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: buildModalSheet,
              icon: const Icon(
                Icons.add,
                size: 27,
              ))
        ],
      ),
      body: media.width < 450
          ? Column(
              children: children,
            )
          : Row(
              children: children,
            ),
    );
  }
}
