import 'package:flutter/material.dart';
import 'package:expense_track/models/expense.dart';

class DatePicker extends StatelessWidget {
  const DatePicker({super.key, required this.selectedDate, required this.onSelectedDate});

  final DateTime? selectedDate;
  final void Function(DateTime?) onSelectedDate;

  void _presentDatePicker(BuildContext context) async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );

    onSelectedDate(pickedDate);


  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            selectedDate == null
                ? 'No date selected'
                : formatter.format(selectedDate!),
          ),
          IconButton(
            onPressed: () {
              _presentDatePicker(context);
            },
            icon: const Icon(Icons.calendar_month),
          ),
        ],
      ),
    );
  }
}
