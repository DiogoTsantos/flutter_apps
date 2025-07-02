import 'package:flutter/material.dart';
import 'package:flutter_web/widget/item_product.dart';
import 'package:flutter_web/widget/mobile_appbar.dart';
import 'package:flutter_web/widget/web_appbar.dart';

class LojaVirtual extends StatelessWidget {
  const LojaVirtual({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;
        double height = AppBar().preferredSize.height;
        return Scaffold(
          appBar: width < 600
            ? PreferredSize(
              preferredSize: Size(
                width,
                height
              ),
              child: const MobileAppBar()
            )
            : PreferredSize(
              preferredSize: Size(
                width,
                height
              ),
              child: const WebAppBar()
            ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: GridView.count(
              crossAxisCount: _fixView(width),
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              children: [
                ItemProduct(
                  descrition: 'Kit Multimídia',
                  price: '2.000,00',
                  image: 'p1.jpg',
                ),
                ItemProduct(
                  descrition: 'Pneu Goodyear aro 16',
                  price: '800,00',
                  image: 'p2.jpg',
                ),
                ItemProduct(
                  descrition: 'Samsung 9',
                  price: '4.150,00',
                  image: 'p3.jpg',
                ),
                ItemProduct(
                  descrition: 'Samsung Edge',
                  price: '2.150,00',
                  image: 'p4.jpg',
                ),
                ItemProduct(
                  descrition: 'Galaxy 10',
                  price: '6.300,00',
                  image: 'p5.jpg',
                ),
                ItemProduct(
                  descrition: 'Iphone 11',
                  price: '12.000,00',
                  image: 'p6.jpg',
                ),
                ItemProduct(
                  descrition: 'Kit Multimídia',
                  price: '2.000,00',
                  image: 'p1.jpg',
                ),
                ItemProduct(
                  descrition: 'Pneu Goodyear aro 16',
                  price: '800,00',
                  image: 'p2.jpg',
                ),
                ItemProduct(
                  descrition: 'Samsung 9',
                  price: '4.150,00',
                  image: 'p3.jpg',
                ),
                ItemProduct(
                  descrition: 'Samsung Edge',
                  price: '2.150,00',
                  image: 'p4.jpg',
                ),
                ItemProduct(
                  descrition: 'Galaxy 10',
                  price: '6.300,00',
                  image: 'p5.jpg',
                ),
                ItemProduct(
                  descrition: 'Iphone 11',
                  price: '12.000,00',
                  image: 'p6.jpg',
                ),
              ],
            ),
          )
        );
      }
    );
  }

  int _fixView(double width) {
    int columns = 2;

    if ( width <= 600 ) {
      columns = 2;
    } else if ( width <= 1000 ) {
      columns = 3;
    } else {
      columns = 6;
    }
    return columns;
  }
}