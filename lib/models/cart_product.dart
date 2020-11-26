import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:lojinha/models/item_size.dart';

import 'Product.dart';

class CartProduct extends ChangeNotifier {
  CartProduct.fromProduct(this.product) {
    productId = product.id;
    quantity = 1;
    size = product.selectedSize.name;
  }

  CartProduct.fromDocument(DocumentSnapshot document) {
    id = document.documentID;
    productId = document.data['pid'] as String;
    quantity = document.data['quantity'] as int;
    size = document.data['size'] as String;
    firestore.document('products/$productId').get().then((doc) {
      product = Product.fromDocument(doc);
      notifyListeners();
    });
  }

  final Firestore firestore = Firestore.instance;

  String id;

  String productId;
  int quantity;
  String size;
  Product product;

  /*Se o produto for nulo renorna nulo, senão busca o produto pelo tamanho(size) da camisa*/
  ItemSize get itemSize {
    if (product == null) return null;
    return product.findSize(size);
  }

  num get unitPrice {
    if (product == null) return 0;
    return itemSize?.price ?? 0;
  }

  num get totalPrice => unitPrice * quantity;

  Map<String, dynamic> toCartItemMap() {
    return {
      'pid': productId,
      'quantity': quantity,
      'size': size,
    };
  }

  bool stackable(Product product) {
    return product.id == productId && product.selectedSize.name == size;
  }

  //incrementa uma quantidade de produto
  void increment() {
    quantity++;
    notifyListeners();
  }

  //decrementa uma quantidade de produto
  void decrement() {
    quantity--;
    notifyListeners();
  }

  //Se não tenha em estoque o item com o size(tamanho) return false
  bool get hasStrock {
    final size = itemSize;

    if (size == null) return false;

    //senão retorna a quantidade que tem em estoque
    return size.stock >= quantity;
  }
}
