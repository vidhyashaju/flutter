import 'dart:io';

void main(){
  print("Enter the number:");
  var num=int.parse(stdin.readLineSync()!);
  if(num%2==0)
    {
      print("The entered number is Even");
    }
  else
    {
      print("Entered number is Odd");
    }
}