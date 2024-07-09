import 'package:flutter/material.dart';

import '../../utils/RoleValues.dart';

class EditableCell extends StatefulWidget {
  final String initialValue;
  final Function(String) onSubmitted;
  final bool isDropdown;

  EditableCell(
      {required this.initialValue,
      required this.onSubmitted,
      this.isDropdown = false});

  @override
  _EditableCellState createState() => _EditableCellState();
}

class _EditableCellState extends State<EditableCell> {
  bool _isEditing = false;
  final _controller = TextEditingController();
  String dropdownValue = 'Administrator';


  @override
  void initState() {
    super.initState();
    _controller.text = widget.initialValue;
    dropdownValue = roleValues.entries
        .firstWhere((entry) => entry.value == widget.initialValue,
            orElse: () => roleValues.entries.first)
        .key;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isEditing = true;
        });
      },
      child: _isEditing
          ? (widget.isDropdown
              ? DropdownButton<String>(
                  value: dropdownValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                      _isEditing = false;
                      widget.onSubmitted(roleValues[dropdownValue]!);
                    });
                  },
                  items: roleValues.keys
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                )
              : TextField(
                  controller: _controller,
                  onSubmitted: (value) {
                    setState(() {
                      _isEditing = false;
                    });
                    widget.onSubmitted(value);
                  },
                  onTap: () {
                    _controller.selection = TextSelection(
                        baseOffset: 0, extentOffset: _controller.text.length);
                  },
                ))
          : Text(widget.initialValue),
    );
  }
}
