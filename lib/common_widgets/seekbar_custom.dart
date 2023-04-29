import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';

class SeekbarCustom extends StatefulWidget {
  SeekbarCustom({Key? key, required this.value, required this.onDragging})
      : super(key: key);
  double value;
  final Function(int, dynamic, dynamic) onDragging;
  @override
  _SeekbarCustomState createState() => _SeekbarCustomState();
}

class _SeekbarCustomState extends State<SeekbarCustom> {
  double _value = 0;
  @override
  Widget build(BuildContext context) {
    return FlutterSlider(
      values: [_value],
      min: -3,
      max: 3,
      step: FlutterSliderStep(
        step: 0.5,
        isPercentRange: false,
        rangeList: [
          FlutterSliderRangeStep(from: -3, to: -2.5, step: -2.5),
          FlutterSliderRangeStep(from: -2.5, to: -2, step: -2),
          FlutterSliderRangeStep(from: -2, to: -1.5, step: -1.5),
          FlutterSliderRangeStep(from: -1.5, to: -1, step: -1),
          FlutterSliderRangeStep(from: -1, to: -0.5, step: -0.5),
          FlutterSliderRangeStep(from: -0.5, to: 0, step: 0),
          FlutterSliderRangeStep(from: 0, to: 0.5, step: 0),
          FlutterSliderRangeStep(from: 0.5, to: 1, step: 0.5),
          FlutterSliderRangeStep(from: 1, to: 1.5, step: 1),
          FlutterSliderRangeStep(from: 1.5, to: 2, step: 1.5),
          FlutterSliderRangeStep(from: 2, to: 2.5, step: 2),
          FlutterSliderRangeStep(from: 2.5, to: 3, step: 2.5)
        ],
      ),
      onDragging: (handlerIndex, lowerValue, upperValue) {
        widget.onDragging(handlerIndex, lowerValue, upperValue);
        if ((lowerValue as double).isNaN) {
          lowerValue = -3;
        }
        setState(() {
          _value = lowerValue;
          print(_value);
        });
      },
      tooltip: FlutterSliderTooltip(disabled: true),
      handler: FlutterSliderHandler(
        decoration: BoxDecoration(),
        child: Material(
          type: MaterialType.canvas,
          color: Colors.blue,
          elevation: 3,
          child: Container(
              padding: EdgeInsets.all(5), child: Text(_value.toString())),
        ),
      ),
    );
  }
}
