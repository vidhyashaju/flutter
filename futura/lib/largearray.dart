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
  num.sort();
  print("Largest element in the array is :${num.last}");

}