import 'dart:async';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PuzzleUI extends StatefulWidget {
  PuzzleUI({Key? key}) : super(key: key);

  @override
  State<PuzzleUI> createState() => _PuzzleUIState();
}

class _PuzzleUIState extends State<PuzzleUI> {
  double oneDistance = 0;
  double twoDistance = 420;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      height: 500,
      color: Colors.black,
      child: Stack(
        children: [
          AnimatedPositioned(curve: Curves.easeIn,
            duration: Duration(
              milliseconds: 500,
            ),
            top: oneDistance,
            left: 0,
            child: Container(
              color: Colors.white,
              width: 80,
              height: 80,
              child: ElevatedButton(
                child: Text(""),
                onPressed: () {
                  setState(() {
                    oneDistance += 10;
                  });
                },
              ),
            ),
          ),
          AnimatedPositioned(curve: Curves.easeIn,
            duration: Duration(
              milliseconds: 500,
            ),
            top: twoDistance,
            left: 0,
            child: Container(
              color: Colors.white,
              width: 80,
              height: 80,
              child: ElevatedButton(
                child: Text(""),
                onPressed: () {
                  setState(() {
                    oneDistance = 420;
                    twoDistance = 0;
                  });
                  Future.delayed(Duration(seconds: 5));
               
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
