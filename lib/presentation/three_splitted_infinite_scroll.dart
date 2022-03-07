//this file contains the implementation of an inifinitely  horizontaly scrollable listview showing three parts in one viewport

//packages:
import 'dart:async' show Timer;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ThreeSplittedInfiniteScroll extends StatefulWidget {
  ///implementation of an inifinitely  horizontaly scrollable listview showing three parts in one viewport with the following specifications
  ///
  ///`List<Widget> children:` default: three empty texts --> a list containing the Widgets that are displayed on the listviews containers
  ///
  ///`double maxHeight:` default: 30 --> the maximum height of a listview`s container
  ///
  ///`double maxShrinkPercentage:` default: 0.5 --> the minimum percentage of the maxHeight to what the listviews container can be shrunk
  ///
  ///`Color centerColor:` default: Color(0xFF96fd01) --> the color of the item when it is centered in the viewport
  ///
  ///`Color edgeColor:` default: Color(0xFF2C2C2C) --> the color of the item when it is not in the center of the viewport
  ///
  ///`double listWidth:` default: 300 --> the width of the listView
  ///
  ///`double margin:` default: 20 --> the margin between the containers
  ///
  ///`double heightWidthRatio:` default: 1.4 --> how many times do you need to take the maxHeight to get the width
  ///
  ///`BoxShape shape:` default: BoxShape.rectangle --> the shape of the containers
  ///
  ///`borderRadius:` default: BorderRadius.all(Radius.circular(15))  --> the radius of the container´s corners
  ///
  ///`double visibilityPercentage:` The percentage of the maximum addable height the added height of the container needs to reach until its chil is shown
  ///
  ///`double startingPercentage:` the percentage of the maximum addable height the added height of the container needs to reach for the gradient to start
  ///
  ///only has an affect if colorIdentifier == 2
  ///
  ///`int iniitialIndex:` the index of the container that is initially shown in the center
  ///
  ///initialIndex + 1 has to be dividable by children.length or else the first element wil not be in the center
  ///
  ///`colorIdentifier:` specifies how the color of the list´s containers should be calculated
  ///
  ///0: biggest container will have the centerColor the remaining containers will have the edgeColor
  ///
  ///1: all containers will have the centerColor but with different opacity depending on its height
  ///
  ///2: the container will change its color like a gradient from edgeColor to centerColor when it is dragged into the center
  ThreeSplittedInfiniteScroll({
    ValueKey? key,
    this.children = const [Text(""), Text(""), Text("")],
    this.maxHeight = 3,
    this.maxShrinkPercentage = 0.5,
    this.centerColor = const Color(0xFF96fd01),
    this.edgeColor = const Color(0xFF2C2C2C),
    this.listWidth = 300,
    this.margin = 20,
    this.heightWidthRatio = 1.4,
    this.borderRadius = const BorderRadius.all(Radius.circular(15)),
    this.visibilityPercentage = 0.5,
    this.startingPercentage = 0.3,
    this.initialIndex = 50,
    this.colorIdentifier = 0,
    required this.scrollController,
  }) : super(key: key);

  ///a list containing the Widgets that are displayed on the listviews containers
  final List<Widget> children;

  ///the maximum height of a listview`s container
  final double maxHeight;

  ///the minimum percentage of the maxHeight to what the listviews container can be shrunk
  final double maxShrinkPercentage;

  ///the color of the item when it is centered in the viewport
  final Color centerColor;

  ///the color of the item when it is not in the center of the viewport
  final Color edgeColor;

  ///the width of the listView
  final double listWidth;

  ///the margin between the containers
  final double margin;

  ///how many times do you need to take the maxHeight to get the width
  final double heightWidthRatio;

  ///the radius of the container´s corners
  final BorderRadius borderRadius;

  ///the percentage of the maximum addable height the added height of the container needs to reach until its chil is shown
  final double visibilityPercentage;

  ///the percentage of the maximum addable height the added height of the container needs to reach for the gradient to start
  ///
  ///only has an affect if colorIdentifier == 2
  final double startingPercentage;

  ///the index of the container that is initially shown in the center
  ///
  ///initialIndex + 1 has to be dividable by children.length or else the first element wil not be in the center
  final int initialIndex;

  ///specifies how the color of the list´s containers should be calculated
  ///
  ///0: biggest container will have the centerColor the remaining containers will have the edgeColor
  ///
  ///1: all containers will have the centerColor but with different opacity depending on its height
  ///
  ///2: the container will change its color like a gradient from edgeColor to centerColor when it is dragged into the center
  final int colorIdentifier;

  ScrollController scrollController;

  @override
  _ThreeSplittedInfiniteScrollState createState() =>
      _ThreeSplittedInfiniteScrollState();
}

class _ThreeSplittedInfiniteScrollState
    extends State<ThreeSplittedInfiniteScroll> {
  late double containerWidth;
  double relevantOffset = -1;

  @override
  void initState() {
    super.initState();
    containerWidth = widget.maxHeight * widget.heightWidthRatio;
    widget.scrollController = ScrollController(
        initialScrollOffset: containerWidth +
            widget.margin -
            (widget.listWidth - containerWidth) / 2 +
            widget.initialIndex * (containerWidth + widget.margin));
    if (relevantOffset == -1) {
      relevantOffset = widget.scrollController.initialScrollOffset;
    }
    Timer.periodic(Duration(milliseconds: 1), (Timer t) {
      if (mounted == true) {
        setState(() {
          relevantOffset = widget.scrollController.offset;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.maxHeight,
      width: widget.listWidth,
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          },
        ),
        child: ListView.builder(
            controller: widget.scrollController,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(
                  right: widget.margin,
                ),
                color: Colors.transparent,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: retrieveColor(relevantOffset, index),
                          borderRadius: widget.borderRadius),
                      height: widget.maxHeight * widget.maxShrinkPercentage +
                          calculatedAdditionalHeight(relevantOffset, index),
                      width: widget.maxHeight * widget.heightWidthRatio,
                    ),
                    calculatedChildren(relevantOffset, index),
                  ],
                ),
              );
            }),
      ),
    );
  }

  calculatedAdditionalHeight(double offset, int index) {
    double unit = containerWidth + widget.margin;
    double unitCount = offset / unit;
    double remainingUnitPart = unit * (1 - (unitCount % 1));
    double availableHeight =
        widget.maxHeight - widget.maxShrinkPercentage * widget.maxHeight;
    double secondWidth = widget.listWidth - remainingUnitPart;
    if (secondWidth > containerWidth) {
      secondWidth = containerWidth;
    }
    if (index == unitCount.floor()) {
      return availableHeight /
          containerWidth *
          (onlyPositive(remainingUnitPart - widget.margin));
    } else if (index == unitCount.floor() + 1) {
      return availableHeight / containerWidth * secondWidth;
    } else if (index == unitCount.floor() + 2) {
      return availableHeight /
          containerWidth *
          (onlyPositive(widget.listWidth -
              remainingUnitPart -
              secondWidth -
              widget.margin));
    } else {
      return 0;
    }
  }

  //biggest container has the centerColor
  Color calculatedColor0(double offset, int index) {
    if (calculatedAdditionalHeight(offset, index) >
            calculatedAdditionalHeight(offset, index - 1) &&
        calculatedAdditionalHeight(offset, index) >
            calculatedAdditionalHeight(offset, index + 1)) {
      return widget.centerColor;
    } else {
      return widget.edgeColor;
    }
  }

  ///via opacity
  Color calculatedColor1(double maxMultiplier, double multiplier) {
    if (maxMultiplier == multiplier) {
      return widget.centerColor.withOpacity(1 / (maxMultiplier) * (multiplier));
    } else {
      return widget.centerColor.withOpacity(1 / maxMultiplier * multiplier);
    }
  }

  ///via gradient from edgeColor to centerColor
  Color calculatedColor2(double maxMultiplier, double multiplier) {
    if (multiplier < widget.startingPercentage * maxMultiplier) {
      multiplier = 0;
    } else {
      multiplier = multiplier - widget.startingPercentage * maxMultiplier;
    }
    return Color.fromRGBO(
        widget.edgeColor.red +
            ((widget.centerColor.red - widget.edgeColor.red) /
                    ((1 - widget.startingPercentage) * maxMultiplier) *
                    multiplier)
                .round(),
        widget.edgeColor.green +
            ((widget.centerColor.green - widget.edgeColor.green) /
                    ((1 - widget.startingPercentage) * maxMultiplier) *
                    multiplier)
                .round(),
        widget.edgeColor.blue +
            ((widget.centerColor.blue - widget.edgeColor.blue) /
                    ((1 - widget.startingPercentage) * maxMultiplier) *
                    multiplier)
                .round(),
        1);
  }

  Color retrieveColor(double offset, int index) {
    double maxMultiplier =
        widget.maxHeight - widget.maxShrinkPercentage * widget.maxHeight;
    double multiplier =
        double.parse(calculatedAdditionalHeight(offset, index).toString());
    switch (widget.colorIdentifier) {
      case 0:
        return calculatedColor0(offset, index);
      case 1:
        return calculatedColor1(maxMultiplier, multiplier);
      case 2:
        return calculatedColor2(maxMultiplier, multiplier);
      default:
        return calculatedColor0(offset, index);
    }
  }

  calculatedChildren(double offset, int index) {
    if (calculatedAdditionalHeight(offset, index) >=
        (widget.maxHeight - widget.maxShrinkPercentage * widget.maxHeight) *
            widget.visibilityPercentage) {
      return widget.children[index % widget.children.length];
    } else {
      return Text("");
    }
  }
}

///it takes a number and only returns positive number
///
///if the given number is negative it will return 0
double onlyPositive(double n) {
  if (n >= 0) {
    return n;
  }
  return 0;
}
