import 'package:flutter/material.dart';

import '../../function_colors.dart';

class InputField extends StatelessWidget {
  const InputField(
      {required this.hintText, required this.textEditingController, Key? key})
      : super(key: key);

  final TextEditingController textEditingController;
  final String hintText;

  static const double inputFontSize = 20;
  static const double hintFontSize = 15;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(cursorColor: FunctionColors.one,
        controller: textEditingController,
        style: TextStyle(
            fontSize: inputFontSize,
            color: Colors.black,
            fontFamily: "Noteworthy-Light"),
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: FunctionColors.one,
            ),
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.black,
            fontFamily: "Noteworthy-Light",
            fontSize: hintFontSize,
          ),
        ),
      ),
    );
  }
}
