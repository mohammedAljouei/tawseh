import 'package:flutter/material.dart';
import 'explore.dart';
import 'contacts.dart';

class Home extends StatelessWidget {
  final String? userId;
  final String? userName;
  const Home(this.userId, this.userName, {super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.map_sharp)),
              Tab(icon: Icon(Icons.contact_page)),
            ],
          ),
          title: const Text('مرحبا'),
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [Explore(userId, userName), const Contacts()],
        ),
      ),
    );
  }
}
