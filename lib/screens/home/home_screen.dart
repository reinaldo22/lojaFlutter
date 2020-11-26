import 'package:flutter/material.dart';
import 'package:lojinha/common/custom_drawer/custon_drawer.dart';
import 'package:lojinha/models/home_manager.dart';
import 'package:lojinha/screens/home/components/section_list.dart';
import 'package:lojinha/screens/home/components/section_staggered.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromARGB(255, 211, 118, 130),
                Color.fromARGB(255, 253, 181, 168),
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            ),
          ),
          CustomScrollView(
            slivers: [
              SliverAppBar(
                snap: true,
                floating: true,
                elevation: 0,
                backgroundColor: Colors.transparent,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text('Mega Modas'),
                  centerTitle: true,
                ),
                actions: [
                  IconButton(
                    icon: Icon(Icons.shopping_cart),
                    color: Colors.white,
                    onPressed: () => Navigator.of(context).pushNamed('/cart'),
                  ),
                ],
              ),
              Consumer<HomeManager>(builder: (_, homeManager, __) {
                final List<Widget> children =
                    homeManager.section.map<Widget>((section) {
                  switch (section.type) {
                    case 'List':
                      return SectionList(section);
                    case 'Staggered':
                      return Staggered(section);
                    default:
                      return Container();
                  }
                }).toList();
                return SliverList(
                  delegate: SliverChildListDelegate(children),
                );
              }),
            ],
          )
        ],
      ),
    );
  }
}
