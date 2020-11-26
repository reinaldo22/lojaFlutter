import 'package:flutter/material.dart';
import 'package:lojinha/common/custom_drawer/custon_drawer.dart';
import 'package:lojinha/models/page_manager.dart';
import 'package:lojinha/models/user_manager.dart';
import 'package:lojinha/screens/admin_screens/admin_users_screens.dart';
import 'package:lojinha/screens/home/home_screen.dart';
import 'package:lojinha/screens/products/products_screen.dart';
import 'package:provider/provider.dart';

class BaseScreen extends StatelessWidget {
  final PageController pageController = PageController();

//Tela principal
  @override
  Widget build(BuildContext context) {
    return Provider(
        create: (_) => PageManager(pageController),
        child: Consumer<UserManager>(builder: (_, userManager, __) {
          return PageView(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: <Widget>[
              HomeScreen(),
              ProductsScreen(),
              Scaffold(
                drawer: CustomDrawer(),
                appBar: AppBar(
                  title: const Text('Home 3'),
                ),
              ),
              Scaffold(
                drawer: CustomDrawer(),
                appBar: AppBar(
                  title: const Text('Home 4'),
                ),
              ),
              if(userManager.adminEnabled)
              ...[
                AdminUsersScreen(),
                Scaffold(
                  drawer: CustomDrawer(),
                  appBar: AppBar(
                    title: Text('Pedidos'),
                  ),
                ),
              ]
            ],
          );
        }));
  }
}
