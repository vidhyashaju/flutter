import 'dart:io';

void main()
{
  int count=0;
  print("Enter the number:");
  var num=int.parse((stdin.readLineSync()!));
  for(int i=1;i<=num;i++)
    {
      if(num%i==0)
        {
          count++;
        }
    }
  if(count==2)
    {
      print("Number is Prime");
    }
  else
    {
      print("Number is not Prime");
    }

}