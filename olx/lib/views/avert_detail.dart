import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:olx/models/advert.dart';
import 'package:url_launcher/url_launcher.dart';

class AdvertDetail extends StatefulWidget {
  final Advert advert;
  const AdvertDetail({super.key, required this.advert});

  @override
  State<AdvertDetail> createState() => _AdvertDetailState();
}

class _AdvertDetailState extends State<AdvertDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anúncio'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              FlutterCarousel(
                options: CarouselOptions(
                  height: 250.0,
                  viewportFraction: 1.0,
                  showIndicator: true,
                  slideIndicator: CircularSlideIndicator(
                    currentIndicatorColor: Theme.of(context).primaryColor,
                    indicatorBackgroundColor: Colors.white54,
                    padding: const EdgeInsets.only(bottom: 15),
                  ),
                ),
                items: widget.advert.photos!.map((image) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          image: DecorationImage(
                            image: NetworkImage(image),
                            fit: BoxFit.fitWidth
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'R\$ ${widget.advert.price}',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).primaryColor
                      ),
                    ),
                    Text(
                      '${widget.advert.title}',
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Divider(),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        'Descrição',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(
                        '${widget.advert.description}',
                        style: const TextStyle(
                          fontSize: 18
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Divider(),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        'Contato',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 66),
                      child: Text(
                        '${widget.advert.phone}',
                        style: const TextStyle(
                          fontSize: 18
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: GestureDetector(
              child: Container(
                padding: const EdgeInsets.all(16),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(30)
                ),
                child: const Text(
                  'Ligar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20
                  ),
                ),
              ),
              onTap: () {
                _callPhone(widget.advert.phone!);
              },
            ),
          ),
        ],
      ),
    );
  }
  
  void _callPhone(String number) async {
    if ( await canLaunchUrl(Uri.parse('tel:+55-$number'))) {
      await launchUrl(Uri.parse('tel:+55-$number'));
    } else {
      throw 'Could not launch $number';
    }

  }
}