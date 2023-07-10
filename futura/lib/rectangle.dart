//calculate the area of a rectangle
import 'dart:io';

void main()
{
  print("Enter the length:");
  var length=double.parse(stdin.readLineSync()!);
  print("Enter the width:");
  var width=double.parse(stdin.readLineSync()!);
  var area=length*width;
  print("Area of rectangle is $area");
}