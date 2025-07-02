import 'package:flutter/material.dart';

class ItemProduct extends StatelessWidget {
  String? descrition;
  String? price;
  String? image;
  ItemProduct({super.key, this.descrition, this.price, this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey
        ),
        color: Colors.white
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Expanded(
            flex: 5,
            child: Image.asset(
              'images/${image!}',
              fit: BoxFit.contain,
            )
          ),
          const SizedBox(height: 10,),
          Expanded(
            flex: 1,
            child: Text(descrition!)
          ),
          const SizedBox(height: 5,),
          Expanded(
            flex: 1,
            child: Text(
              'R\$ ${price!}',
              style: const TextStyle(
                fontWeight: FontWeight.bold
              ),
            )
          )
        ],
      ),
    );
  }
}