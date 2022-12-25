import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'home.dart';

class Auth extends StatelessWidget {
  Auth({super.key});
  final myControllerUserName = TextEditingController();
  final myControllerPass = TextEditingController();

  Future<void> addUserPoints(String userId, BuildContext context) async {
    CollectionReference points =
        FirebaseFirestore.instance.collection('points');

    points.add({'userId': userId, 'long': 'xxx', 'lat': 'xxx'});

    // ignore: no_leading_underscores_for_local_identifiers
    AndroidOptions _getAndroidOptions() => const AndroidOptions(
          encryptedSharedPreferences: true,
        );
    final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());

// Write value
    await storage.write(key: 'userId', value: userId);
    // ignore: use_build_context_synchronously
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Home()),
    );

// Read value
    //String? value = await storage.read(key: 'test');

// Read all values
    //Map<String, String> allValues = await storage.readAll();

// Delete value
    // await storage.delete(key: key);

// Delete all
    //await storage.deleteAll();
  }

  void addUser(String userName, String pass, BuildContext context) async {
    List<DocumentSnapshot> documentList;
    // check if user exist
    documentList = (await FirebaseFirestore.instance
            .collection("users")
            .where("username", isEqualTo: userName)
            .get())
        .docs;

    if (documentList.isEmpty) {
      // no such user
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      await users.add({
        'username': userName,
        'pass': pass,
      }).then((value) => addUserPoints(value.id, context));
    } else {
      // there is a user
      if (documentList[0]
              .data()
              .toString()
              .split(' ')[1]
              .toString()
              .split(',')[0] ==
          pass) {
        // log him in
        // ignore: no_leading_underscores_for_local_identifiers
        AndroidOptions _getAndroidOptions() => const AndroidOptions(
              encryptedSharedPreferences: true,
            );
        final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());

// Write value

        await storage.write(key: 'userId', value: documentList[0].id);
        print(documentList[0].id);
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      } else {
        print('wrong user name or pass');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // addUser('yyu');
    //checkUserExist('ss');
    return Scaffold(
      appBar: AppBar(
        title: const Text('مرحبا'),
      ),
      body: Column(
        children: [
          Container(
            height: 150.0,
            width: 190.0,
            padding: const EdgeInsets.only(top: 40),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(200),
            ),
            child: Center(
              child: Image.asset('assets/images/i1.jpg'),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
                controller: myControllerUserName,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'اسم المستخدم',
                )),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
                controller: myControllerPass,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'كلمة المرور',
                )),
          ),
          Container(
            height: 50,
            width: 250,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(20)),
            child: ElevatedButton(
              onPressed: () {
                addUser(
                    myControllerUserName.text, myControllerPass.text, context);
              },
              child: const Text(
                'دخول',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
