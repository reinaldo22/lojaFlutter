import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojinha/models/user.dart';
import 'package:lojinha/models/user_manager.dart';

class AdminUsersManager extends ChangeNotifier {
  List<Usuario> users = [];

  Firestore firestore = Firestore.instance;
  StreamSubscription _subscription;

  void updateUser(UserManager userManager) {
    _subscription?.cancel();
    if (userManager.adminEnabled) {
      _listenToUsers();
    } else {
      users.clear();
      notifyListeners();
    }
  }

  void _listenToUsers() {
    firestore.collection('users').snapshots().listen((snapshot) {
      users = snapshot.documents.map((e) => Usuario.fromDocument(e)).toList();
      //organiza a lista por alfabeto e maiusculas
      users
          .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

      notifyListeners();
    });
  }

  List<String> get names => users.map((e) => e.name).toList();

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
