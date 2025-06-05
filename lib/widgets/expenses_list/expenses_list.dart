import 'package:expense_track/models/expense.dart';
import 'package:expense_track/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
  });

  final void Function(Expense expense) onRemoveExpense;
  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, idx) => Dismissible(
        key: ValueKey(expenses[idx]),
        background: Container(
          color: Theme.of(context).colorScheme.error.withValues(alpha: 0.75),
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
        ),
        onDismissed: (direction) {
          onRemoveExpense(expenses[idx]);
        },
        child: ExpenseItem(expenses[idx]),
      ),
    );
  }
}
