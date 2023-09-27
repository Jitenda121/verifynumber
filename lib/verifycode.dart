import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/postscreenn.dart';

class obito extends StatefulWidget {
  final String verifactionId;
  const obito({Key? key, required this.verifactionId}) : super(key: key);

  @override
  State<obito> createState() => _obitoState();
}

class _obitoState extends State<obito> {
  bool loading = false;
  final vphonenumbercontroller = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("verify"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            const SizedBox(height: 50),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: vphonenumbercontroller,
              decoration: const InputDecoration(hintText: "6 digit code"),
            ),
            const SizedBox(height: 50),
            SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      loading = false;
                    });
                    final Credential = PhoneAuthProvider.credential(
                        verificationId: widget.verifactionId,
                        smsCode: vphonenumbercontroller.text.toString());
                    try {
                      await auth.signInWithCredential(Credential);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => postscreen()));
                    } catch (e) {
                      setState(() {
                        loading = false;
                      });
                      // Utils().toast
                    }
                  },
                  child: Text("verify "),
                ))
          ],
        ),
      ),
    );
  }
}
