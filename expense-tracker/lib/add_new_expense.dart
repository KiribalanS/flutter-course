import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:expense_tracker/model.dart';

class AddNewExpense extends StatefulWidget {
  const AddNewExpense(this.addExp, {super.key});
  final void Function(ExpenseModel) addExp;
  @override
  State<AddNewExpense> createState() => _AddNewExpenseState();
}

class _AddNewExpenseState extends State<AddNewExpense> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime expenseDate = DateTime.now();
  Categories selectedCateogory = Categories.leisure;

  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    super.dispose();
  }

  void showAlertDialog(content) {
    showDialog(
      context: context,
      builder: (context) => Container(
        height: 250,
        // color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              content,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("close"),
            ),
          ],
        ),
      ),
    );
  }

  void submitExpenseData() {
    if (titleController.text.trim() == "") {
      showAlertDialog("Please enter a title for your expense.");
      return;
    } else if (amountController.text.trim() == "") {
      showAlertDialog("Please enter some amount for your expense.");
      return;
    } else {
      double amount = double.parse(amountController.text);
      if (amount <= 0) {
        showAlertDialog("Please enter some amount for your expense.");
        return;
      }
      widget.addExp(
        ExpenseModel(
          amount: amount,
          category: selectedCateogory,
          date: expenseDate,
          title: titleController.text,
        ),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final txtFields = [
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: titleController,
            decoration: const InputDecoration(
              label: Text("Title"),
            ),
            maxLength: 50,
          ),
        ),
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: amountController,
                  decoration: const InputDecoration(
                    label: Text("Amount"),
                    prefixText: "Rs. ",
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(
                width: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 17.0),
                child: Expanded(
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 10.0),
                        child: Text("Select date!"),
                      ),
                      IconButton(
                        icon: const Icon(Icons.calendar_today),
                        onPressed: () async {
                          final selectedDate = await showDatePicker(
                            context: context,
                            firstDate: DateTime(2024, 1, 1),
                            lastDate: DateTime.now().add(
                              const Duration(days: 365),
                            ),
                          );
                          setState(() {
                            expenseDate = selectedDate ?? DateTime.now();
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ];
    final media = MediaQuery.of(context).size;
    final keyBoardInset = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;
      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(12.0, 40, 12, keyBoardInset + 12),
          child: SizedBox(
            width: media.width,
            height: media.height,
            child: Column(
              children: [
                width > 450
                    ? SizedBox(
                        width: width,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ...txtFields,
                          ],
                        ),
                      )
                    : const SizedBox(),
                width < 450
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: titleController,
                          decoration: const InputDecoration(
                            label: Text("Title"),
                          ),
                          maxLength: 50,
                        ),
                      )
                    : const SizedBox(),
                width < 450
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: amountController,
                                decoration: const InputDecoration(
                                  label: Text("Amount"),
                                  prefixText: "Rs. ",
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            const SizedBox(
                              width: 40,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 17.0),
                              child: Expanded(
                                child: Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(right: 10.0),
                                      child: Text("Select date!"),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.calendar_today),
                                      onPressed: () async {
                                        final selectedDate =
                                            await showDatePicker(
                                          context: context,
                                          firstDate: DateTime(2024, 1, 1),
                                          lastDate: DateTime.now().add(
                                            const Duration(days: 365),
                                          ),
                                        );
                                        setState(() {
                                          expenseDate =
                                              selectedDate ?? DateTime.now();
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Text("Selected Date : "),
                      Text(
                        DateFormat.yMMMEd().format(expenseDate),
                        style: const TextStyle(
                          height: 4,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: DropdownButton(
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                          value: Categories.leisure,
                          items: Categories.values
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e.name.toUpperCase()),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedCateogory = value ?? Categories.leisure;
                            });
                          },
                        ),
                      ),
                      ElevatedButton(
                        onPressed: submitExpenseData,
                        child: const Text("Save Expense!"),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 75,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
