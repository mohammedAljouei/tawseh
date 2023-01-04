import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'screens/auth.dart';
import 'screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? userId;
  String? userName;
  bool checked = false;

  void getUserId() async {
    // ignore: no_leading_underscores_for_local_identifiers
    AndroidOptions _getAndroidOptions() => const AndroidOptions(
          encryptedSharedPreferences: true,
        );
    final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());

    // await storage.deleteAll(); // delete them all
    String? value = await storage.read(key: 'userId');
    String? value2 = await storage.read(key: 'userName');

    setState(() {
      userId = value;
      userName = value2;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!checked) {
      getUserId();
      setState(() {
        checked = true;
      });
    }
    return MaterialApp(
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("fa", "IR"), // OR Locale('ar', 'AE') OR Other RTL locales
      ],
      locale: const Locale(
          "fa", "IR"), // OR Locale('ar', 'AE') OR Other RTL locales,
      title: 'Rate',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: userId == null ? Auth() : Home(userId, userName),
    );
  }
}
