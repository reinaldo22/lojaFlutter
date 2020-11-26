import 'package:flutter/material.dart';
import 'package:lojinha/models/sections.dart';
import 'package:lojinha/screens/home/components/item_tile.dart';
import 'package:lojinha/screens/home/components/section_header.dart';

class SectionList extends StatelessWidget {
  final Section section;

  SectionList(this.section);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(section),
          SizedBox(
            height: 200,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) {
                  return ItemTile(section.items[index]);
                },
                separatorBuilder: (_, __) => const SizedBox(
                      width: 4,
                    ),
                itemCount: section.items.length),
          ),
        ],
      ),
    );
  }
}
