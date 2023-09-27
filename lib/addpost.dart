import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/toast.dart';

class addpost extends StatefulWidget {
  const addpost({super.key});

  @override
  State<addpost> createState() => _addpostState();
}

class _addpostState extends State<addpost> {
  final postcontroller = TextEditingController();
  bool loading = false;
  final databaseRef = FirebaseDatabase.instance.ref('post');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("adddpost")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            TextFormField(
              maxLines: 3,
              controller: postcontroller,
              decoration: InputDecoration(
                  hintText: 'what is your mind', border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                    //loading=loading;
                    onPressed: () {
                      loading = loading;
                      setState(() {
                        loading = true;
                      });
                      databaseRef
                          .child(
                              DateTime.now().microsecondsSinceEpoch.toString())
                          .set({
                        'title': postcontroller.text.toString(),
                        'id': DateTime.now().microsecondsSinceEpoch.toString()
                      }).then((value) {
                        utils().toastmessage('post added');
                        setState(() {
                          loading = false;
                        });
                      }).onError((error, stackTrace) {
                        utils().toastmessage(error.toString());
                        setState(() {
                          loading = false;
                        });
                      });
                    },
                    child: Text("add")))
          ],
        ),
      ),
    );
  }
}
