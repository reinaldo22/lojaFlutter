import 'package:flutter/material.dart';
import 'package:lojinha/models/sections.dart';

class SectionHeader extends StatelessWidget {

  final Section section;

  SectionHeader(this.section);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        section.name,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: 18
        ),
      ),
    );
  }
}
