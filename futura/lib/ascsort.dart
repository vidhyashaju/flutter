//numbers in ascending order
import 'dart:io';

void main()
{
  List<int> a=[];
  print("Enter the limit:");
  var n=int.parse(stdin.readLineSync()!);
  print("Enter $n elements:");
  for(int i=1;i<=n;i++)
    {
      a.add(int.parse(stdin.readLineSync()!));
    }
  a.sort();
  print("The elements in ascending order are : $a");
  a.sort((b,a)=>a.compareTo(b));
  print(a);
 }

