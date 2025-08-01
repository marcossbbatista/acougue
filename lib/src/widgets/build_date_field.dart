import 'package:flutter/material.dart';

class BuildDateField extends StatelessWidget {
  const BuildDateField({
    super.key,
    required this.context,
    required this.controller,
    required this.label,
    required this.selectedDate,
    required this.onDateSelected,
  });

  final BuildContext context;
  final TextEditingController controller;
  final String label;
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        suffixIcon: Icon(Icons.calendar_today, color: Color(0xFF1976D2)),
      ),
      onTap: () async {
        final novaData = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (novaData != null) {
          onDateSelected(novaData);
        }
      },
    );
  }
}
