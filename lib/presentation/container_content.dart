import 'package:flutter/material.dart';
import 'package:polynom_puzzle/presentation/textStyles/white_bold_text.dart';

import 'colored_container.dart';
import 'lobby.dart';

class ContainerContent extends StatelessWidget {
  final String title;
  final List<Widget> children;

  ContainerContent(
    this.title, {
    this.children = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: ColoredContainer.sideLength / 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WhiteBoldText(
            fontSize: Lobby.categoryFontSize,
            text: title,
          ),
          ...children,
        ],
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      ),
    );
  }
}
