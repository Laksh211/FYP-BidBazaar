import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RangeSlider extends StatefulWidget {
  RangeSlider({super.key, required this.values, required this.labels});
  RangeValues values;
  RangeLabels labels;
  @override
  State<RangeSlider> createState() => _RangeSliderState();
}

class _RangeSliderState extends State<RangeSlider> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Slider(
        value: 20,
        onChanged: (value) {},
      ),
    );
  }
}
