import 'package:flutter/material.dart';

class CustomFilterDropdown extends StatefulWidget {
  final List<String> options;
  final String initialValue;
  final ValueChanged<String> onChanged;

  const CustomFilterDropdown({
    Key? key,
    required this.options,
    required this.initialValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  _FilterDropdownState createState() => _FilterDropdownState();
}

class _FilterDropdownState extends State<CustomFilterDropdown> {
  late String selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: selectedValue,
        icon: const Icon(Icons.arrow_drop_down, size: 20),
        style: const TextStyle(fontSize: 14, color: Colors.black),
        items: widget.options
            .map(
              (String value) =>
                  DropdownMenuItem<String>(value: value, child: Text(value)),
            )
            .toList(),
        onChanged: (newValue) {
          if (newValue != null) {
            setState(() {
              selectedValue = newValue;
            });
            widget.onChanged(newValue);
          }
        },
      ),
    );
  }
}
