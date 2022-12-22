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

  Future<void> addUserPoints(String userId) async {
    CollectionReference points =
        FirebaseFirestore.instance.collection('points');

    points.add({'userId': userId, 'lang': 'sdd', 'lat': 'sss'});
  }

  Future<void> addUser(String username, BuildContext context) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    await users.add({
      'username': username,
    }).then((value) => checkUserExist(value.id, context));

    print('test');
  }

  // do not FORGET about points

  Future<void> checkUserExist(String userId, BuildContext context) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    users.doc(userId).get().then((DocumentSnapshot documentSnapshot) async {
      if (documentSnapshot.exists) {
        print(documentSnapshot.data());
        print('sx');
      } else {
        // untill now NO WAY ENTER HERE
        // Create storage
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
    });
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
          const Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
                obscureText: true,
                decoration: InputDecoration(
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
                addUser(myControllerUserName.text, context);
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
