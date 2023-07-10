//Average and sum of array elements
import 'dart:io';
void main()
{
  List<int> num=[];
  var n,sum=0,avg;
  print("Enter the limit:");
  n=int.parse(stdin.readLineSync()!);
  for(int i=1;i<=n;i++)
    {
      num.add(int.parse(stdin.readLineSync()!));
    }
  num.forEach((element) {
    sum=sum+element;
  });
print("Sum of element is :$sum");
avg=sum/n;
print("Average of elements is :$avg");
 }