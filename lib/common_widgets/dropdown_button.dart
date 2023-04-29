import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giongreviewphim/constants.dart';
import 'package:giongreviewphim/controllers/content_controller.dart';
import 'package:giongreviewphim/models/options.dart';

class DropdownOptions extends StatefulWidget {
  DropdownOptions(
      {Key? key,
      required this.value,
      required this.options,
      required this.onChange})
      : super(key: key);
  final List<Option> options;
  final String value;
  final Function(String) onChange;
  @override
  _DropdownOptionsState createState() => _DropdownOptionsState();
}

class _DropdownOptionsState extends State<DropdownOptions> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        hint: Text(
          'Select Item',
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).hintColor,
          ),
        ),
        items: widget.options
            .map((item) => DropdownMenuItem<String>(
                  value: item.value,
                  child: Text(
                    item.text,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ))
            .toList(),
        value: widget.value,
        onChanged: (value) {
          widget.onChange(value!);
        },
        buttonStyleData: ButtonStyleData(
          height: 50,
          width: double.infinity,
          padding: const EdgeInsets.only(left: 14, right: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: Colors.black26,
            ),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
        ),
      ),
    );
  }
}
