import 'package:flutter/material.dart';
import 'package:lojinha/common/custom_drawer/custon_drawer.dart';
import 'package:lojinha/models/product_manager.dart';
import 'package:lojinha/screens/products/components/products_list_tile.dart';
import 'package:provider/provider.dart';

import 'components/search_dialog.dart';

//tela com todos os produtos
class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar:
          AppBar(title: Text('Produtos'), centerTitle: true, actions: <Widget>[
        Consumer<ProductManager>(builder: (_, productManager, __) {
          if (productManager.search.isEmpty) {
            return IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                final search = await showDialog<String>(
                    context: context, builder: (_) => SearchDialog());
                if (search != null) {
                  productManager.search = search;
                }
              },
            );
          } else {
            return IconButton(
              icon: Icon(Icons.close),
              onPressed: () async {
                productManager.search = '';
              },
            );
          }
        })
      ]),
      body: Consumer<ProductManager>(
        builder: (_, productManager, __) {
          final filteredProducts = productManager.filteredProducts;
          return ListView.builder(
              padding: EdgeInsets.all(6),
              itemCount: filteredProducts.length,
              itemBuilder: (_, index) {
                return ProductsListTile(filteredProducts[index]);
              });
        },
      ),
    );
  }
}
