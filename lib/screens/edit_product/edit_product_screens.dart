import 'package:flutter/material.dart';
import 'package:lojinha/models/Product.dart';
import 'package:lojinha/screens/edit_product/components/images_form.dart';

class EditProductScreen extends StatelessWidget {

  Product product;

  EditProductScreen(this.product);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar anúncio'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ImagesForm(product),
        ],
      ),
    );
  }
}