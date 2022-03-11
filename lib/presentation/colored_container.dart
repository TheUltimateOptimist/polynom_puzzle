import 'package:flutter/material.dart';

class ColoredContainer extends Container {
  static const double sideLength = 300;
  static const double cornerRadius = 10;

  ColoredContainer(Color color,
      {Widget? child, final void Function()? onPressed, final bool ignorePointer = false,})
      : super(
          width: sideLength,
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
