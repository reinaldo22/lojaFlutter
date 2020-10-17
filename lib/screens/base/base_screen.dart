import 'package:flutter/material.dart';
import 'package:lojinha/common/custom_drawer/custon_drawer.dart';
import 'package:lojinha/models/page_manager.dart';
import 'package:lojinha/screens/products/products_screen.dart';
import 'package:provider/provider.dart';

class BaseScreen extends StatelessWidget {
  final PageController pageController = PageController();



//Tela principal
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManager(pageController),
      child: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          Scaffold(
              drawer: CustomDrawer(),
              appBar: AppBar(
                title: const Text('Home'),
              )
              ),
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
        ],
      ),
    );
  }
}
