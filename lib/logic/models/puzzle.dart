import 'package:polynom_puzzle/logic/models/function_part.dart';
import 'package:polynom_puzzle/logic/models/puzzle_function.dart';

abstract class Puzzle{

  List<FunctionPart> parts;
  static const int dimensions = 4;
  late final PuzzleFunction expectedFunction;

  Puzzle({required this.parts});

  void changeParts(FunctionPart partOne, FunctionPart partTwo){
    for(int i = 0; i < parts.length; i++){
      if(parts[i].id == partOne.id){
        parts[i] = partTwo;
      }
      else if(parts[i].id == partTwo.id){
        parts[i] = partOne;
      }
    }
  }

  List<FunctionPart> getRow(int id){
    List<FunctionPart> partRow = List.empty(growable: true);
    for(int i = id*dimensions; i < (id + 1)*dimensions; i++){
      partRow.add(parts[i]);
    }
    return partRow;
  }

  List<List<FunctionPart>> asTwoDimList(){
    List<List<FunctionPart>> result = List.empty(growable: true);
    for(int i = 0; i < parts.length; i+=dimensions){
      result.add(parts.sublist(i, i + dimensions));
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