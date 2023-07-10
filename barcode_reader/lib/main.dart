import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(home: Barcode(),);
  }
}
class Barcode extends StatefulWidget {
  const Barcode({Key? key}) : super(key: key);

  @override
  State<Barcode> createState() => _BarcodeState();
}

class _BarcodeState extends State<Barcode> {
  String scanResult='scan barcode';
  Future<void> barcodeReader()async{
    String barcode=FlutterBarcodeScanner.getBarcodeStreamReceiver(lineColor, cancelButtonText, isShowFlashIcon, scanMode)
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(

    );
  }
}

