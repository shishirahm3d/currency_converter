import 'package:flutter/material.dart';

class DropdownRow extends StatelessWidget {
  final String label;
  final String value;
  final Map currencies;
  final void Function(String?) onChanged;
  final TextStyle labelStyle;

  const DropdownRow({
    required this.label,
    required this.value,
    required this.currencies,
    required this.onChanged,
    this.labelStyle = const TextStyle(color: Colors.black, fontSize: 16),
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: labelStyle.copyWith(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: DropdownButton<String>(
            borderRadius: BorderRadius.circular(15),
            menuMaxHeight: 500.0,
            value: value,
            icon: const Icon(Icons.arrow_drop_down_rounded),
            isExpanded: true,
            onChanged: onChanged,
            dropdownColor: const Color(0xFF883f9f), // Set dropdown menu box color to #883f9f
            items: currencies.keys
                .toSet()
                .toList()
                .map<DropdownMenuItem<String>>((value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  '$value - ${currencies[value]}',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
      ],
    );
  }
}
