//print odd and even elements in an array
import 'dart:io';

void main()
{
  List<int> num=[],odd=[],even=[];
  print("Enter the limit:");
  var n=int.parse(stdin.readLineSync()!);
  print("Enter $n elemnts");
  for(int i=1;i<=n;i++)
    {
      num.add(int.parse(stdin.readLineSync()!));
    }
  num.forEach((element) {
    if(element%2==0)
      {
       even.add(element);

      }
    else
      {
        odd.add(element);

      }
    });

  print("even elements are $even");
  print("odd elements are $odd");
}