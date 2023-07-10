//to print fibonacci series
import 'dart:io';

void main()
{
  int a=0,b=1,c;
  print("Enter the limit:");
  int n=int.parse(stdin.readLineSync()!);
  print("$n Fibonacci series are :");
  print(a);
  print(b);
  for(int i=2;i<n;i++)
    {
      c=a+b;
      a=b;
      b=c;
      print(c);
    }

}