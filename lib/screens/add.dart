import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class Add extends StatelessWidget {
  String? userID;
  Add(this.userID, {super.key});
  final myControllerFriendUserName = TextEditingController();

  void addFriend(String friendUserName) async {
    List<DocumentSnapshot> documentList;
    // check if friend exist
    documentList = (await FirebaseFirestore.instance
            .collection("friends")
            .where("friendUserName", isEqualTo: friendUserName)
            .get())
        .docs;

    if (documentList.isEmpty) {
      // no such friend
      List<DocumentSnapshot> documentListCheckUserExist;
      // check if user exist
      documentListCheckUserExist = (await FirebaseFirestore.instance
              .collection("users")
              .where("username", isEqualTo: friendUserName)
              .get())
          .docs;

      if (documentListCheckUserExist.isNotEmpty &&
          documentListCheckUserExist[0].id != userID) {
        //ther is a user
        CollectionReference friends =
            FirebaseFirestore.instance.collection('friends');
        await friends.add({
          'friendUserName': friendUserName,
          'userId': userID,
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  controller: myControllerFriendUserName,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'اسم المستخدم',
                  )),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: ElevatedButton(
                onPressed: () {
                  addFriend(myControllerFriendUserName.text);
                },
                child: const Text(
                  'اضافة صديق',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
          ],
        ));
  }
}
