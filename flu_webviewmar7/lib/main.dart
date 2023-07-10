import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
void main()
{
  runApp(MyApp());

}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WebView(),
    );
  }
}
class WebView extends StatefulWidget {
   WebView({Key? key}) : super(key: key);

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
 late WebViewController _controller;
 Location location=Location();
 LocationData? locationData;
 var locdata;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller=WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(Uri.parse("https://google.com"));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(child:Icon(Icons.my_location_outlined),onPressed:()async{

          locdata= await location.getLocation();
          setState(() {
            locationData=locdata;
          });

        _controller.loadRequest(Uri.parse("https://www.google.com/maps/@${locationData!.latitude},${locationData!.longitude},15z"));}),
        body:
        WebViewWidget(
            controller:_controller ),

      ),
    );
  }
}

