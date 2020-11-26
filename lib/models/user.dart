import 'package:cloud_firestore/cloud_firestore.dart';

class Usuario {
  Usuario({this.email, this.password, this.name, this.id});

  //Recupera o usuario atravès de um documento firebase
  Usuario.fromDocument(DocumentSnapshot document) {
    id = document.documentID;
    name = document.data['name'] as String;
    email = document.data['email'] as String;
  }

  String id;
  String name;
  String email;
  String password;
  String confirmPassword;
  bool admin = false;

  DocumentReference get firestoreRef =>
      Firestore.instance.document('users/$id');

  CollectionReference get cartReference => firestoreRef.collection('cart');

  Future<void> saveData() async {
    //await Firestore.instance.collection('users').document(id).setData(toMap());

    await firestoreRef.setData(toMap());
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
    };
  }
}
