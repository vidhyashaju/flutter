//print elements in descending order
import 'dart:io';

void main() {
  List<int> a = [];
  print("Enter the limit:");
  var n = int.parse(stdin.readLineSync()!);
  print("Enter $n elements:");
  for (int i = 1; i <= n; i++) {
    a.add(int.parse(stdin.readLineSync()!));
  }
  a.sort();
  print("The elements in descending order are :");
  a.sort((b, a) => a.compareTo(b));
  print(a);
}