import 'package:flutter/material.dart';
import 'package:flutter_application_1/addpost.dart';

class realtime extends StatefulWidget {
  const realtime({super.key});

  @override
  State<realtime> createState() => _realtimeState();
}

class _realtimeState extends State<realtime> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("post"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => addpost(),
              ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
