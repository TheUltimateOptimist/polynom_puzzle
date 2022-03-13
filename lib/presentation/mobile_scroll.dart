import 'package:flutter/material.dart';
import 'package:polynom_puzzle/presentation/three_splitted_infinite_scroll.dart';

import '../constants/sizes.dart';
import 'colored_container.dart';
import 'lobby.dart';

class MobileScroll extends ThreeSplittedInfiniteScroll{
  MobileScroll(final List<Widget> children) : super(scrollController: ScrollController(),
                    visibilityPercentage: 0.0,
                    children: children,
                    maxHeight: ColoredContainer.sideLength,
                    heightWidthRatio: Lobby.heightWidthRatio,
                    listWidth: Sizes.totalWidth,
                    maxShrinkPercentage: 0.6,);
}