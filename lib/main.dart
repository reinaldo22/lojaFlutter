import 'package:flutter/material.dart';
import 'package:lojinha/models/user_manager.dart';
import 'package:lojinha/screens/base/base_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(MyApp());

  /*  cria uma colecao com os dados
  Firestore.instance.collection('pedidos').add(
    {'preco': 199.99, 'usuario':'Reinaldo'}
  );
      atualiza os dados
  Firestore.instance.collection('pedidos').document('001').updateData(
    {'usuario': 'Reinaldo Vargas'}
  );
      lê dados

     DocumentSnapshot document = await Firestore.instance.collection('pedidos').document('55Nu5n7fOHfaLZO7NJtk').get();
     print(document.data);
  */
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserManager(),
      child: MaterialApp(
        title: 'Loja do Reinaldo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color.fromARGB(255, 4, 125, 141),
          scaffoldBackgroundColor: Color.fromARGB(255, 4, 125, 141),
          appBarTheme: const AppBarTheme(
            elevation: 0,
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: BaseScreen(),
      ),
    );
  }
}
