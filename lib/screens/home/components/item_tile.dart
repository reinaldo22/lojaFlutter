import 'package:flutter/material.dart';
import 'package:lojinha/models/product_manager.dart';
import 'package:lojinha/models/section_item.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class ItemTile extends StatelessWidget {

  const ItemTile(this.item);

  final SectionItem item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(item.product != null){
          final product = context.read<ProductManager>()
              .findProductById(item.product);
          if(product != null){
            Navigator.of(context).pushNamed('/productDetail', arguments: product);
          }
        }
      },
      child: AspectRatio(
        aspectRatio: 1,
        child: FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: item.image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}