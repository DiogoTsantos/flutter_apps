import 'package:aprenda_ingles/screens/animals.dart';
import 'package:aprenda_ingles/screens/numbers.dart';
import 'package:aprenda_ingles/screens/vowels.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {

  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
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
        centerTitle: true,
        title: const Text('Aprenda inglês'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorWeight: 4,
          labelStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold
          ),
          tabs: const [
            Tab(
              text: 'Bichos',
            ),
            Tab(
              text: 'Números',
            ),
            Tab(
              text: 'Vogais',
            ),
          ]
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Animals(),
          Numbers(),
          Vowels()
        ],
      ),
    );
  }
}