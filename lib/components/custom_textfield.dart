import 'package:flutter/material.dart';
import 'package:giongreviewphim/constants.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required TextEditingController editingController,
  }) : _editingController = editingController;

  final TextEditingController _editingController;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget._editingController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.bottomRight, children: [
      TextField(
        textAlign: TextAlign.start,
        controller: widget._editingController,
        style: const TextStyle(fontSize: 18),
        autofocus: false,
        expands: true,
        maxLines: null, // allows for unlimited lines
        maxLength: Constants.maxLength,
        keyboardType: TextInputType.multiline, // allows for multiline input
        decoration: InputDecoration(
          hintText: 'Enter your text here', // placeholder text
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
          ), // add an outline border
          counterText: '',
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 10.0, right: 10.0),
        child: Text(
          '${widget._editingController.text.length}/${Constants.maxLength}',
          style: const TextStyle(
            fontSize: 14.0,
            color: Colors.white,
          ),
        ),
      ),
    ]);
  }
}
