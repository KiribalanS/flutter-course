import 'package:expense_tracker/expenses.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

enum Categories {
  food,
  entertainment,
  leisure,
  travel,
}

const cateogoryIcons = {
  Categories.food: "🍔",
  Categories.entertainment: "🎥",
  Categories.leisure: "👀",
  Categories.travel: "🚄",
};

class ExpenseModel {
  final String id;
  final double amount;
  final DateTime date;
  final Categories category;
  final String title;

  String get formatedDate {
    return "${DateFormat('EEEE').format(date)}\n${DateFormat.yMd().format(date)}";
  }

  ExpenseModel({
    required this.amount,
    required this.category,
    required this.date,
    required this.title,
  }) : id = const Uuid().v4();
}

class ExpenseBucket {
  const ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  ExpenseBucket.forCategory(List<ExpenseModel> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  final Categories category;
  final List<ExpenseModel> expenses;

  double get totalExpenses {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount; // sum = sum + expense.amount
    }

    return sum;
  }
}
