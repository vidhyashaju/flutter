//check number is palindrome or not
import 'dart:io';

void main()
{
  int rem,s=0,temp;
  print("Enter the number:");
  int num=int.parse(stdin.readLineSync()!);
  temp=num;
  while(num!=0)
    {
      rem=num%10;
      s=s*10+rem;
      num=(num/10).toInt();
    }
    if(temp==s)
      {
        print("The number is Palindrome");
      }
    else
      {
        print("The number is not Palindrome");
      }
}