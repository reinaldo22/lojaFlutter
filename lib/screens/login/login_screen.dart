import 'package:flutter/material.dart';
import 'package:lojinha/helpers/validators.dart';
import 'package:lojinha/models/user.dart';
import 'package:lojinha/models/user_manager.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Entrar"),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Consumer<UserManager>(
            builder:(_, userManager, __){
              return Form(
            key: formKey,
            child: ListView(
              padding: EdgeInsets.all(16),
              shrinkWrap: true,
              children: <Widget>[
                TextFormField(
                  controller: emailController,
                  enabled: !userManager.loading,
                  decoration: InputDecoration(hintText: 'E-mail'),
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  validator: (email) {
                    if (!emailValid(email)) return 'E-mail inválido';

                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: passwordController,
                  enabled: !userManager.loading,
                  decoration: InputDecoration(hintText: 'Senha'),
                  autocorrect: false,
                  obscureText: true,
                  validator: (pass) {
                    if (pass.isEmpty) return 'Senha Inválida';
                    return null;
                  },
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                      onPressed: () {},
                      padding: EdgeInsets.zero,
                      child: Text('Esqueci minha senha')),
                ),
                SizedBox(height: 16),
                SizedBox(
                  height: 44,
                  child: RaisedButton(
                    onPressed: userManager.loading ? null : () {
                      if (formKey.currentState.validate()) {
                        context.read<UserManager>().signIn(
                            usuario: Usuario(
                                email: emailController.text,
                                password: passwordController.text),
                            onFail: (e) {
                              scaffoldKey.currentState.showSnackBar(
                                SnackBar(
                                  content: Text('Falha ao entrar $e'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            },
                            onSuccess: () {
                              //TODO: FECHAR TELA DE LOGIN
                            });
                      }
                    },
                    color: Theme.of(context).primaryColor,
                    disabledColor: Theme.of(context).primaryColor.withAlpha(100),
                    child: userManager.loading ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    ) : Text(
                      'Entrar',
                      style: TextStyle(fontSize: 18),
                    ),
                    textColor: Colors.white,
                  ),
                ),
              ],
            ),
          );
            }),
        ),
      ),
    );
  }
}
