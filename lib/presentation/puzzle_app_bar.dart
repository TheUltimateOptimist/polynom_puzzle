import 'package:flutter/material.dart';
import 'package:polynom_puzzle/presentation/pokes.dart';
import 'package:polynom_puzzle/presentation/textStyles/black_bold_text.dart';

import 'lobby.dart';

class PuzzleAppBar extends AppBar{
  static const double height = 90;
  PuzzleAppBar(final String title, {final Widget? rank}) : super(iconTheme: IconThemeData(
                  color: Colors.black,
                  size: Lobby.menuSize,
                ),
                foregroundColor: Colors.black,
                titleSpacing: 0.0,
                leadingWidth: Lobby.menuSize * 2,
                toolbarHeight: 90,
                elevation: 0,
                backgroundColor: Colors.white,
                title: Container(
                  margin: EdgeInsets.only(
                    left: 20,
                    top: 20,right: rank != null ? 20 : 0,
                  ),
                  child: Row(mainAxisSize: rank != null ? MainAxisSize.max : MainAxisSize.min,mainAxisAlignment: rank != null ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
                    children: [Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BlackBoldText(
                          fontSize: 35,
                          text: title,
                        ),
                        Pokes(),
                      ],
                    ),
                    if(rank != null) rank,
                    ],
                  ),
                ),);
}