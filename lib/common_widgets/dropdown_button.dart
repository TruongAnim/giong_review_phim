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
  List<DropdownMenuItem<String>> _addDividersAfterItems(List<Option> items) {
    List<DropdownMenuItem<String>> _menuItems = [];
    for (var item in items) {
      _menuItems.addAll(
        [
          DropdownMenuItem<String>(
            value: item.value,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                item.text,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
          //If it's last item, we will not add Divider after it.
          if (item != items.last)
            const DropdownMenuItem<String>(
              enabled: false,
              child: Divider(
                thickness: 2,
                color: Color(0xffABEBC6),
              ),
            ),
        ],
      );
    }
    return _menuItems;
  }

  List<double> _getCustomItemsHeights() {
    List<double> _itemsHeights = [];
    for (var i = 0; i < (widget.options.length * 2) - 1; i++) {
      if (i.isEven) {
        _itemsHeights.add(40);
      }
      //Dividers indexes will be the odd indexes
      if (i.isOdd) {
        _itemsHeights.add(4);
      }
    }
    return _itemsHeights;
  }

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
        items: _addDividersAfterItems(widget.options),
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
        menuItemStyleData: MenuItemStyleData(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          customHeights: _getCustomItemsHeights(),
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 300,
          padding: null,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: const Color(0xffE8F8F5),
          ),
          elevation: 8,
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: MaterialStateProperty.all(6),
            thumbVisibility: MaterialStateProperty.all(true),
          ),
        ),
      ),
    );
  }
}
