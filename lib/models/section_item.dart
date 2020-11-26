class SectionItem {
  String image;
  String product;

  //pega o dado direto do firebase e passa para um map
  SectionItem.fromMap(Map<String, dynamic> map) {
    image = map['image'] as String;
    product = map['product'] as String;
  }

  @override
  String toString() {
    return 'SectionItem{image: $image, product: $product}';
  }
}
