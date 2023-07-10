//Sum of Digits
import 'dart:io';
void main()
{
  int rem,sum=0;
  print("Enter the digit:");
  int num=int.parse(stdin.readLineSync()!);
  while(num!=0)
    {
      rem=num%10;
      sum=sum+rem;
      num=(num/10).toInt();
    }
    print("Sum of Digits is :$sum");
}