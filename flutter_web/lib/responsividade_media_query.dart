import 'package:flutter/material.dart';

class ResponsividadeMediaQuery extends StatefulWidget {
  const ResponsividadeMediaQuery({super.key});

  @override
  State<ResponsividadeMediaQuery> createState() => _ResponsividadeMediaQueryState();
}

class _ResponsividadeMediaQueryState extends State<ResponsividadeMediaQuery> {
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
      body: Row(
        children: [
          Container(
            width: widthItem,
            height: height - heightStatusBar - heightAppBar,
            color: Colors.green,
          ),
          Container(
            width: widthItem,
            height: height - heightStatusBar - heightAppBar,
            color: Colors.red,
          )
        ],
      ),
    );
  }
}