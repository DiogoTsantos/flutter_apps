import 'package:flutter/material.dart';

class BasicAnimation extends StatefulWidget {
  const BasicAnimation({super.key});

  @override
  State<BasicAnimation> createState() => _BasicAnimationState();
}

class _BasicAnimationState extends State<BasicAnimation> {

  bool _status = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Animation'),
      ),
      /*body: AnimatedContainer(
        duration: const Duration(seconds: 1),
        color: Colors.green,
        padding: const EdgeInsets.only(bottom: 100, top: 20),
        alignment: _status ? Alignment.bottomCenter : Alignment.topCenter,
        child: AnimatedOpacity(
          duration: const Duration(seconds: 1),
          opacity: _status ? 1 : 0,
          child: Container(
            height: 50,
            child: Icon(
              Icons.airplanemode_active,
              size: 50,
              color: Colors.white,
            ),
          ),
        ),
      ),*/

      body: GestureDetector(
        onTap: () {
          setState(() {
            _status = !_status;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.linear,
          alignment: Alignment.center,
          width: _status ? 60 : 160,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(30)
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: AnimatedOpacity(
                  opacity: _status ? 1 : 0,
                  duration: const Duration(milliseconds: 100),
                  child: const Icon(Icons.person_add, color: Colors.white,),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: AnimatedOpacity(
                  opacity: _status ? 0 : 1,
                  duration: const Duration(milliseconds: 100),
                  child: const Text(
                    'Mesagem',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        elevation: 6,
        child: const Icon(
          Icons.add_box
        ),
        onPressed: () {
          setState(() {
            _status = !_status;
          });
        }
      ),
    );
  }
}