abstract class FunctionPart{
  int id;
  late double leftDistance;
  late double topDistance;

  FunctionPart({required this.id});
  
  double getY(double x);

  FunctionPart copyWith(double leftDistance, double topDistance);
}