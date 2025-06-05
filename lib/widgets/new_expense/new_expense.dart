import 'package:expense_track/widgets/new_expense/actions_row.dart';
import 'package:expense_track/widgets/new_expense/custom_text_field.dart';
import 'package:expense_track/widgets/new_expense/date_picker.dart';
import 'package:flutter/material.dart';
import 'package:expense_track/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpense();
  }
}

class _NewExpense extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _dropdownChangeFn(Category? value) {
    if (value == null) {
      return;
    }
    setState(() {
      _selectedCategory = value;
    });
  }

  void updateDate(DateTime? pickedDate) {
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;

    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          //контекст именно этого диалоговогоь окна
          title: const Text('Invalid input'),
          content: const Text('Please make sure a valid inputs was entered...'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );

      return;
    }

    widget.onAddExpense(
      Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory,
      ),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(
      builder: (context, constranins) {
        final width = constranins.maxWidth;

        return SizedBox(
          height: double.infinity, //чтоб занимала простансва сколько возможно
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (width >= 600)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: CustomTextField(
                            label: 'Title',
                            textFieldLenght: 50,
                            controller: _titleController,
                          ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: CustomTextField(
                            controller: _amountController,
                            label: 'Amount',
                            prefixText: '\$',
                            type: TextInputType.number,
                          ),
                        ),
                      ],
                    )
                  else
                    CustomTextField(
                      label: 'Title',
                      textFieldLenght: 50,
                      controller: _titleController,
                    ),
                  if (width >= 600)
                    Row(
                      children: [
                        DropdownButton(
                          value: _selectedCategory,
                          items: Category.values
                              .map(
                                (category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(category.name.toUpperCase()),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }

                            setState(() {
                              _selectedCategory = value;
                            });
                          },
                        ),
                        const SizedBox(width: 24),
                        DatePicker(
                          selectedDate: _selectedDate,
                          onSelectedDate: updateDate,
                        ),
                      ],
                    )
                  else
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            controller: _amountController,
                            label: 'Amount',
                            prefixText: '\$',
                            type: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: 16),
                        DatePicker(
                          selectedDate: _selectedDate,
                          onSelectedDate: updateDate,
                        ),
                      ],
                    ),
                  const SizedBox(height: 16),
                  ActionsRow(
                    onSubmitData: _submitExpenseData,
                    selectedCategory: _selectedCategory,
                    onChangeFn: _dropdownChangeFn,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
