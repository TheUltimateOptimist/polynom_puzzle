import 'package:polynom_puzzle/logic/models/function_part.dart';
import 'package:polynom_puzzle/logic/models/puzzle_function.dart';

abstract class Puzzle{

  List<FunctionPart> parts;
  static const int rowLength = 4;
  static  int coumnLength = 4;
  late final PuzzleFunction expectedFunction;

  Puzzle({required this.parts});

  void changeParts(FunctionPart partOne, FunctionPart partTwo){
    
    final double oneLeftDistance = partOne.leftDistance;
    final double oneTopDistance = partOne.topDistance;
    partOne.leftDistance = partTwo.leftDistance;
    partOne.topDistance = partTwo.topDistance;
    partTwo.leftDistance = oneLeftDistance;
    partTwo.topDistance = oneTopDistance;
  }

  List<FunctionPart> getRow(int id){
    List<FunctionPart> partRow = List.empty(growable: true);
    for(int i = id*rowLength; i < (id + 1)*rowLength; i++){
      partRow.add(parts[i]);
    }
    return partRow;
  }

  List<List<FunctionPart>> asTwoDimList(){
    List<List<FunctionPart>> result = List.empty(growable: true);
    for(int i = 0; i < parts.length; i+=rowLength){
      result.add(parts.sublist(i, i + rowLength));
      // if(i + dimensions + 1 < parts.length){
      //   result.add(parts.sublist(i, i + dimensions + 1)); 
      // }
      // else {
      //   result.add(parts.sublist(i));
      // }
    }
    return result;
   }

   bool isPartOfFunction(FunctionPart part);

  PuzzleFunction getCurrentFunction();

   bool isSolved(); 
}