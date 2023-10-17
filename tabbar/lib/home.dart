import 'package:flutter/material.dart';
import 'package:tabbar/first_page.dart';
import 'package:tabbar/second_page.dart';
import 'package:tabbar/third_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Abas'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              // text: 'Home',
              icon: Icon(Icons.home),
            ),
            Tab(
              // text: 'E-mail',
              icon: Icon(Icons.email),
            ),
            Tab(
              // text: 'Conta',
              icon: Icon(Icons.account_circle),
            ),
          ]
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          FirstPage(),
          SecondPage(),
          ThirdPage(),
        ]
      ),
    );
  }
}