import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:lojinha/models/Product.dart';

class ProductManager extends ChangeNotifier {
  final Firestore firestore = Firestore.instance;

  //Minha lista de produtos passada para um array vazio
  List<Product> allProduct = [];

//variavel que recebe o valor buscado de produtos
  String _search = '';

  //get da variavel search
  String get search => _search;

  //set da variavel search que recebe um valor e notifica para o provider
  set search(String value) {
    _search = value;
    notifyListeners();
  }

  List<Product> get filteredProducts{
    final List<Product> filteredProducts = [];

    if(search.isEmpty){
      filteredProducts.addAll(allProduct);
    }else{
      //Pego todos os meus produtos e verifico se contem em minusculo a busca que esta fazendo
      filteredProducts.addAll(
        allProduct.where((p) => p.name.toLowerCase().contains(search.toLowerCase()))
      );
    }
    return filteredProducts;
  }

  ProductManager() {
    _loadAllProducts();
  }

//Busca todos os produtos
  void _loadAllProducts() async {
    final QuerySnapshot snapProducts =
        await firestore.collection('products').getDocuments();

    //o document em objeto
    allProduct =
        snapProducts.documents.map((d) => Product.fromDocument(d)).toList();

    //notifica ao provider
    notifyListeners();
  }
}
