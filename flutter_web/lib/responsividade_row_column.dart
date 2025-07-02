import 'package:flutter/material.dart';

class ResponsividadeRowColumn extends StatefulWidget {
  const ResponsividadeRowColumn({super.key});

  @override
  State<ResponsividadeRowColumn> createState() => _ResponsividadeRowColumnState();
}

class _ResponsividadeRowColumnState extends State<ResponsividadeRowColumn> {
  @override
  Widget build(BuildContext context) {
     double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double heightStatusBar = MediaQuery.of(context).padding.top;
    double heightAppBar = AppBar().preferredSize.height;
    double widthItem = width / 2;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Responsividade'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 5,
        shadowColor: Colors.black,
      ),
      body: Column(
        children: [
          // Container(
          //   height: 200,
          //   color: Colors.blue,
          // ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.green,
            )
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.black12,
            )
          ),
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.amber,
            )
          )
        ],
      )
    );
  }
}