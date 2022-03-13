import 'package:flutter/cupertino.dart';

class ResponsiveExpanded extends StatelessWidget {
  final bool applyExpanded;
  final Widget child;
  const ResponsiveExpanded({this.applyExpanded = true,required  this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(applyExpanded){
      return Expanded(child: child);
    }
    else{
      return child;
    }
  }
}