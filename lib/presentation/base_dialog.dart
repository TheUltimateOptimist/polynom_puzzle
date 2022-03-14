import 'package:flutter/material.dart';

import '../constants/sizes.dart';

class BaseDialog extends StatelessWidget {
  final CrossAxisAlignment crossAxisAlignment;
  final double additionalMargin;
  final Widget? child;
  const BaseDialog({this.child,this.additionalMargin = 0, Key? key, this.crossAxisAlignment = CrossAxisAlignment.start}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(
        horizontal:
             Sizes.onMobile ? Sizes.totalWidth / 2 - 150 : Sizes.totalWidth / 2 - 250,
        vertical:
             Sizes.onMobile ? Sizes.totalHeight / 2 - 170 - 0.5*MediaQuery.of(context).viewInsets.bottom : Sizes.totalHeight / 2 - 250,
      ),
      alignment: Alignment.center,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.white,
      child: Container(
          margin:  EdgeInsets.only(
            top: !Sizes.onMobile ? 40 : 20,
            bottom: 10,
            left: 15 +additionalMargin,
            right: 15 + additionalMargin,
          ),
          child: child,),
    );
  }
}
