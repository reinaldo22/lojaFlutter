import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:lojinha/models/sections.dart';

class HomeManager extends ChangeNotifier{
  HomeManager() {
    _loadSections();
  }

  List<Section> section = [];

  //instancio o firestore
  final Firestore firestore = Firestore.instance;

  //Carrega todas as secoes do firebase
  Future<void> _loadSections() async {
    //limpa sections antigas para não duplicar com as novas
    section.clear();

    firestore.collection('home').snapshots().listen((snapshot) {
      for (final DocumentSnapshot document in snapshot.documents) {
        section.add(Section.fromDocument(document));
      }
      notifyListeners();
    });
  }
}
