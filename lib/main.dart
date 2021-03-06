import 'package:flutter/material.dart';
import 'package:lojinha/models/admins_users_manager.dart';
import 'package:lojinha/models/cart_manager.dart';
import 'package:lojinha/models/home_manager.dart';
import 'package:lojinha/models/product_manager.dart';
import 'package:lojinha/models/user_manager.dart';
import 'package:lojinha/screens/base/base_screen.dart';
import 'package:lojinha/screens/cart/cart_screen.dart';
import 'package:lojinha/screens/edit_product/edit_product_screens.dart';
import 'package:lojinha/screens/login/login_screen.dart';
import 'package:lojinha/screens/productsDetail/produc_detail_screen.dart';
import 'package:lojinha/screens/signup/signup_screen.dart';
import 'package:provider/provider.dart';

import 'models/Product.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => ProductManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => HomeManager(),
          lazy: false,
        ),
        ChangeNotifierProxyProvider<UserManager, CartManager>(
          create: (_) => CartManager(),
          lazy: false,
          update: (_, userManager, cartManager) =>
              cartManager..updateUser(userManager),
        ),
        ChangeNotifierProxyProvider<UserManager, AdminUsersManager>(
          create: (_) => AdminUsersManager(),
          lazy: false,
          update: (_, userManager, adminUsersManager) =>
              adminUsersManager..updateUser(userManager),
        ),
      ],
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

        //Rotas de tela
        initialRoute: '/base',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/login':
              return MaterialPageRoute(builder: (_) => LoginScreen());
            case '/cart':
              return MaterialPageRoute(builder: (_) => CartScreen());
            case '/signup':
              return MaterialPageRoute(builder: (_) => SignupScreen());
            case '/productDetail':
              return MaterialPageRoute(
                  builder: (_) => ProductDetail(settings.arguments as Product));
            case '/edit_product':
              return MaterialPageRoute(
                  builder: (_) =>
                      EditProductScreen(settings.arguments as Product));
            case '/base':
            default:
              return MaterialPageRoute(builder: (_) => BaseScreen());
          }
        },
      ),
    );
  }
}
