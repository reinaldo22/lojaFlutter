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

  FirebaseUser user;

  /*Cria a variável booleana para o provider referente ao circularProgress e os campos e botoes inativos de login e passa como falsa*/
  bool _loading = false;

  /*Pega o carregamento dentro da varável privada*/
  bool get loading => _loading;

  /*Função ue autentica usuario no firebase*/
  Future<void> signIn(
      {Usuario usuario, Function onFail, Function onSuccess}) async {
    /*Enquanto estiver fazendo a autenticação, será true*/
    loading = true;

    try {
      /*Autentica usuário no firebase*/
      final AuthResult result = await auth.signInWithEmailAndPassword(
          email: usuario.email, password: usuario.password);


          user = result.user;

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
  Future<void> _loadCurrentUser() async {
    final FirebaseUser currentUser = await auth.currentUser();
    if (currentUser != null) {
      user = currentUser;
      print(user.uid);
    }
    notifyListeners();
  }
}
