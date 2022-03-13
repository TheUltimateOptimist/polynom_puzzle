import 'package:flutter/material.dart';

enum Collection{
  row,column,listView
}

class RowColumnListView extends StatelessWidget {
  final List<Widget>? children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;
  final Collection collectionType;
  final Axis scrollDirection;
  const RowColumnListView({required this.collectionType,this.scrollDirection = Axis.vertical,this.children,this.mainAxisAlignment = MainAxisAlignment.start,this.crossAxisAlignment = CrossAxisAlignment.center,this.mainAxisSize = MainAxisSize.max,Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(collectionType == Collection.row){
      return Row(children: children  ?? [], crossAxisAlignment: crossAxisAlignment,mainAxisAlignment: mainAxisAlignment,mainAxisSize: mainAxisSize,);
    }
    else if(collectionType == Collection.column){
      return Column(children: children ?? [], crossAxisAlignment: crossAxisAlignment,mainAxisAlignment: mainAxisAlignment,mainAxisSize: mainAxisSize,);
    }
    else if(collectionType == Collection.listView){
      return ListView(children: children ?? [],scrollDirection: scrollDirection,);
    }
    else throw Exception("");
  }
}