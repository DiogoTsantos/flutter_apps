import 'package:flutter/material.dart';
import 'package:whatsapp/message_box.dart';
import 'package:whatsapp/message_list.dart';
import 'package:whatsapp/model/user.dart';

// ignore: must_be_immutable
class Messages extends StatefulWidget {
  UserApp? contact;
  Messages(this.contact, {super.key});

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              maxRadius: 20,
              backgroundColor: Colors.grey,
              backgroundImage: NetworkImage(widget.contact!.urlImage),
            ),
            const SizedBox( width: 15),
            Text(widget.contact!.name),
          ],
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/bg.png'),
            fit: BoxFit.cover
          )
        ),
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                MessageList( widget.contact ),
                MessageBox( widget.contact )
              ],
            ),
          ),
        ),
      ),
    );
  }
}