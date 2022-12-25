// tabs screen  [add contacts / explore]

import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Home extends StatelessWidget {
  Home({super.key});
  WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://www.youtube.com/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse('https://tawseh-1.web.app'));

  @override
  Widget build(BuildContext context) {
    // Create storage
    // ignore: no_leading_underscores_for_local_identifiers
    AndroidOptions _getAndroidOptions() => const AndroidOptions(
          encryptedSharedPreferences: true,
        );
    final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
    storage.deleteAll();
    return Scaffold(
      appBar: AppBar(
        title: const Text('مرحبا'),
      ),
      body: WebViewWidget(controller: controller),
      // body: Column(
      //   children: [
      //     Container(
      //       height: 150.0,
      //       width: 190.0,
      //       padding: const EdgeInsets.only(top: 40),
      //       decoration: BoxDecoration(
      //         borderRadius: BorderRadius.circular(200),
      //       ),
      //       // child: Center(
      //       //   child: Image.asset('assets/images/i1.jpg'),
      //       // ),
      //       // child: const GoogleMap(
      //       //   initialCameraPosition: CameraPosition(
      //       //       target: LatLng(37.4, -122.08), zoom: 14.4746),
      //       // ))
      //       child: WebViewWidget(controller: controller),
      //     )
      //   ],
      // ),
    );
  }
}
