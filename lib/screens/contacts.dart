import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ffi';
import 'add.dart';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Contacts extends StatefulWidget {
  const Contacts({super.key});

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  late List<DocumentSnapshot> friends = [];

  void getF() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    AndroidOptions _getAndroidOptions() => const AndroidOptions(
          encryptedSharedPreferences: true,
        );
    final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
    String? userID = await storage.read(key: 'userId');

    List<DocumentSnapshot> documentList;
    documentList = (await FirebaseFirestore.instance
            .collection("friends")
            .where("userId", isEqualTo: userID)
            .get())
        .docs;
    print('tessssssssssssssssst');
    print(documentList.length);
    print(documentList);

    setState(() {
      friends = documentList;
      DocumentSnapshot<Object?> test = documentList[0];

      friends.insert(0, test);
      print(friends[0]['friendUserName']);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getF();
  }

  @override
  Widget build(BuildContext context) {
    return Root(
      items: List<ListItem>.generate(
        friends.length,
        (i) => i == 0
            ? HeadingItem('الاصدقاء')
            : MessageItem('اسم المستخدم', friends[i]['friendUserName']),
      ),
    );
  }
}

class Root extends StatelessWidget {
  final List<ListItem> items;

  const Root({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // Let the ListView know how many items it needs to build.
      itemCount: items.length + 1,
      // Provide a builder function. This is where the magic happens.
      // Convert each item into a widget based on the type of item it is.
      itemBuilder: (context, index) {
        if (index == items.length) {
          return Align(
            alignment: Alignment.bottomLeft,
            child: FloatingActionButton(
              onPressed: () async {
                AndroidOptions _getAndroidOptions() => const AndroidOptions(
                      encryptedSharedPreferences: true,
                    );
                final storage =
                    FlutterSecureStorage(aOptions: _getAndroidOptions());
                String? userID = await storage.read(key: 'userId');
                // ignore: use_build_context_synchronously
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Add(userID)),
                );
              },
              backgroundColor: Colors.green,
              child: const Icon(Icons.add),
            ),
          );
        }

        final item = items[index];

        return ListTile(
          title: item.buildTitle(context),
          subtitle: item.buildSubtitle(context),
        );
      },
    );
  }
}

/// The base class for the different types of items the list can contain.
abstract class ListItem {
  /// The title line to show in a list item.
  Widget buildTitle(BuildContext context);

  /// The subtitle line, if any, to show in a list item.
  Widget buildSubtitle(BuildContext context);
}

/// A ListItem that contains data to display a heading.
class HeadingItem implements ListItem {
  final String heading;

  HeadingItem(this.heading);

  @override
  Widget buildTitle(BuildContext context) {
    return Text(
      heading,
      style: Theme.of(context).textTheme.headline5,
    );
  }

  @override
  Widget buildSubtitle(BuildContext context) => const SizedBox.shrink();
}

/// A ListItem that contains data to display a message.
class MessageItem implements ListItem {
  final String sender;
  final String body;

  MessageItem(this.sender, this.body);

  @override
  Widget buildTitle(BuildContext context) => Text(sender);

  @override
  Widget buildSubtitle(BuildContext context) => Text(body);
}
