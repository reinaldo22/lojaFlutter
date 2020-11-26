import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:lojinha/helpers/firebase_errors.dart';
import 'package:lojinha/models/user.dart';

class UserManager extends ChangeNotifier {
  /*Se caso logado Chama usuário logado logo que chama o UserManager*/
  UserManager() {
    _loadCurrentUser();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final Firestore firestore = Firestore.instance;

  Usuario usuario;

  /*Cria a variável booleana para o provider referente ao circularProgress e os campos e botoes inativos de login e passa como falsa*/
  bool _loading = false;

  /*Pega o carregamento dentro da varável privada*/
  bool get loading => _loading;

  bool get isLoggedIn => usuario != null;

  //Cadastro de usuário
  Future<void> signUp(
      {Usuario usuario, Function onFail, Function onSuccess}) async {
    loading = true;

    try {
      final AuthResult result = await auth.createUserWithEmailAndPassword(
          email: usuario.email, password: usuario.password);

      //user = result.user;

      usuario.id = result.user.uid;
      this.usuario = usuario;

      await usuario.saveData();

      onSuccess();
    } on PlatformException catch (e) {
      onFail(getErrorString(e.code));
    }
    loading = false;
  }

  /*Função ue autentica usuario no firebase*/
  Future<void> signIn(
      {Usuario usuario, Function onFail, Function onSuccess}) async {
    /*Enquanto estiver fazendo a autenticação, será true*/
    loading = true;

    try {
      /*Autentica usuário no firebase*/
      final AuthResult result = await auth.signInWithEmailAndPassword(
          email: usuario.email, password: usuario.password);

      //Pega o usuàrtio do firebase e manda para o metodo loadCurrentUser
      await _loadCurrentUser(firebaseUser: result.user);

      onSuccess();
    } on PlatformException catch (e) {
      onFail(getErrorString(e.code));
    }

    /*No fim da autenticacao será falso */
    loading = false;
  }

  /*Seta o loading e notifica para o provider*/
  set loading(bool value) {
    _loading = value;

    notifyListeners();
  }

  /*Carrega o usuário logado, caso tenha*/
  Future<void> _loadCurrentUser({FirebaseUser firebaseUser}) async {
    final FirebaseUser currentUser = firebaseUser ?? await auth.currentUser();
    if (currentUser != null) {
      //Pega dentro da collection users o currentUser.uid(usuario logado no momento)
      final DocumentSnapshot docUser =
          await firestore.collection('users').document(currentUser.uid).get();
      //obtém os dados
      usuario = Usuario.fromDocument(docUser);

      //verifica se o meu usuario se encontra na colecao admin
      final docAdmin =
          await firestore.collection('admins').document(usuario.id).get();
      if (docAdmin.exists) {
        usuario.admin = true;
      }

      notifyListeners();
    }
  }

  //verifica se o admin esta habilitado
  bool get adminEnabled => usuario != null && usuario.admin;

  void signOut() {
    auth.signOut();
    usuario = null;
    notifyListeners();
  }
}
