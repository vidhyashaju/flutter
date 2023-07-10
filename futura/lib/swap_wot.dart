import 'dart:io';

void main()
{
  var num1,num2,temp;
  print("Enter the number1:");
  num1=int.parse(stdin.readLineSync()!);
  print("Enter the number2:");
  num2=int.parse(stdin.readLineSync()!);
  num1=num1+num2;
  num2=num1-num2;
  num1=num1-num2;
  print("Interchanged numbers are $num1 and $num2");
}