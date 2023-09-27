import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class postscreen extends StatefulWidget {
  const postscreen({super.key});

  @override
  State<postscreen> createState() => _postscreenState();
}

class _postscreenState extends State<postscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("success")),
      body: Column(
        children: [
          Text(
            "verify",
            style: TextStyle(fontSize: 100),
          )
        ],
      ),
    );
  }
}
