import 'package:flutter/material.dart';
import 'package:youtube/api.dart';

class Subscriptions extends StatefulWidget {
  const Subscriptions({super.key});

  @override
  State<Subscriptions> createState() => _SubscriptionsState();
}

class _SubscriptionsState extends State<Subscriptions> {
   final Api _api = Api();

  _listSubscriptions() {
    // return _api.getSubscriptions();
  }

  @override
  Widget build(BuildContext context) {
    _listSubscriptions();
    return const Center(
      child: Text('Inscrições')
    );
  }
}