//calculate the area of a square
import 'dart:io';

void main()
{
  print("Entet the side:");
  var side=double.parse(stdin.readLineSync()!);
  var area=side*side;
  print("Area of square is $area");
}