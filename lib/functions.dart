List<List<dynamic>> copyTwoDimList(List<List<dynamic>> list){
  return toTwoDimList(List.of(toOneDimList(list)), list[0].length);
}

//returned list is completely independent from given list
List<List<dynamic>> twoDimListSorted(List<List<dynamic>> list, [int Function(dynamic a, dynamic b)? comparefunc]){
  List<dynamic> oneDimList = toOneDimList(list);
  oneDimList.sort(comparefunc);
  return toTwoDimList(oneDimList, list[0].length);
}

List<dynamic> toOneDimList(List<List<dynamic>> list){
  List<dynamic> newList = List.empty(growable: true);
  for(int i = 0; i < list.length; i++){
    for(int j = 0; j < list[0].length; j++){
      newList.add(list[i][j]);
    }
  }
  return newList;
}

List<List<dynamic>> toTwoDimList(List<dynamic> list, int rowLength){
  List<List<dynamic>> newList = List.empty(growable: true);
  int rowNumber = 0;
  while(true){
    List<dynamic> row = List.empty(growable: true);
    for(int i = 0; i < rowLength; i++){
      row.add(list[rowNumber*rowLength] + i);
    }
    newList.add(row);
    rowNumber++;
    if(rowNumber*rowLength == list.length){
      break;
    }
  }
  return newList;
}