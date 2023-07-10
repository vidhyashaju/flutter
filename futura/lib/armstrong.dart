//check Armstrong number
import 'dart:io';

void main()
{
  int rem,sum=0,temp,num;
  print("Enter the number:");
  num=int.parse(stdin.readLineSync()!);
  temp=num;
  while(temp!=0)
    {
      rem=num%10;
      sum=sum+(rem*rem*rem);
      temp=(temp/10).toInt();
    }
    if(num==sum)
      {
        print("Number is Armstrong");
      }
    else
      {
        print("Number is not an Armstrong");
      }
}