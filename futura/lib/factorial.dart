//Factorial of a number
import 'dart:io';
void main()
{
  int fact=1;
 print("Enter the number:");
 int n=int.parse(stdin.readLineSync()!);
 for(int i=1;i<=n;i++)
   {
     fact=fact*i;
   }
 print("The Factorial of $n is :$fact");
}