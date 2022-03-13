import 'package:flutter/material.dart';
import 'package:polynom_puzzle/presentation/lobby.dart';

import '../constants/sizes.dart';

class ColoredContainer extends Container {
  static const double sideLength = 300;
  static const double cornerRadius = 10;

  ColoredContainer(Color color,
      {Widget? child, final void Function()? onPressed, final bool ignorePointer = false,})
      : super(
          width: !Sizes.onMobile ? sideLength*Sizes.multiplierLight : sideLength*Lobby.heightWidthRatio,
          height: sideLength,
          color: Colors.transparent,
          child: IgnorePointer(ignoring: ignorePointer,
            child: ElevatedButton(
              onPressed:onPressed,
              child: child,
              style: ElevatedButton.styleFrom(
                primary: color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      cornerRadius,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
}
