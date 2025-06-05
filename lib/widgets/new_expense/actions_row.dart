import 'package:expense_track/models/expense.dart';
import 'package:flutter/material.dart';

class ActionsRow extends StatelessWidget {
  const ActionsRow({
    super.key,
    required this.onSubmitData,
    required this.selectedCategory,
    required this.onChangeFn
  });

  final void Function() onSubmitData;
  final Category selectedCategory;
  final void Function(Category? value) onChangeFn;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Row(
      children: [
        if (width <= 600)
          DropdownButton(
            value: selectedCategory,
            items: Category.values
                .map(
                  (category) => DropdownMenuItem(
                    value: category,
                    child: Text(category.name.toUpperCase()),
                  ),
                )
                .toList(),
            onChanged: onChangeFn
          ),
        const Spacer(),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel Editing'),
        ),
        ElevatedButton(
          onPressed: onSubmitData,
          child: const Text('Save Expense'),
        ),
      ],
    );
  }
}
