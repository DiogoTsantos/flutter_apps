import 'package:flutter/material.dart';
import 'package:youtube/screens/library.dart';
import 'package:youtube/screens/on_the_rise.dart';
import 'package:youtube/screens/start.dart';
import 'package:youtube/screens/subscription.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    List<Widget> screens = [
      const Start(),
      const OnTheRise(),
      const Subscriptions(),
      const Library(),
    ];

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.grey
        ),
        backgroundColor: Colors.white,
        title: Image.asset(
          'images/youtube.png',
          width: 100,
        ),
        actions: const [
          /*IconButton(
            onPressed: () => print('video cam'),
            icon: const Icon( Icons.videocam )
          ),
          const IconButton(
            onPressed: null,
            icon: Icon( Icons.account_circle )
          ),*/
          IconButton(
            onPressed: null,
            icon: Icon( Icons.search )
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: screens[_currentIndex]
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
        },
        fixedColor: Colors.red,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            label: 'Início',
            icon: Icon( Icons.home )
          ),
          BottomNavigationBarItem(
            label: 'Em alta',
            icon: Icon(Icons.whatshot)
          ),
          BottomNavigationBarItem(
            label: 'Inscrições',
            icon: Icon(Icons.subscriptions)
          ),
          BottomNavigationBarItem(
            label: 'Biblioteca',
            icon: Icon(Icons.folder)
          ),
        ]
      ),
    );
  }
}