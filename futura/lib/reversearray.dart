import 'dart:io';

void main()
{
  List<int> num=[];
  print("Enter the limit:");
  var n=int.parse(stdin.readLineSync()!);
  print("Enter $n elements:");
  for(int i=1;i<=n;i++)
  {
    num.add(int.parse(stdin.readLineSync()!));
  }
  print("Reversed array elements are : ${num.reversed.toList()}");

}