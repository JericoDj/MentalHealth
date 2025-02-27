import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main () {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Testing",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Hello World"),


        ),

        body: Center(
          child: ElevatedButton(onPressed: () {
            _launchURL;
          }, child: Text("texting")),

        ),
      ),

    );
  }
}




void _launchURL() async {
  final Uri url = Uri.parse('https://flutter.dev');
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}

