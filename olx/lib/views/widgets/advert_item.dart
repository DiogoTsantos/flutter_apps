import 'package:flutter/material.dart';
import 'package:olx/models/advert.dart';

class AdvertItem extends StatelessWidget {
  final Advert advert;
  final VoidCallback? onTapItem;
  final VoidCallback? onTapRemove;
  const AdvertItem({super.key, required this.advert, this.onTapItem, this.onTapRemove});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapItem,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child: Image.network(advert.photos!.first, fit: BoxFit.cover),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        advert.title!,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text('R\$ ${advert.price}'),
                    ]
                  ),
                ),
              ),
              if ( onTapRemove != null )
                Expanded(
                  flex: 1,
                  child: MaterialButton(
                    onPressed: onTapRemove,
                    color: Colors.red,
                    padding: const EdgeInsets.all(10),
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}