import 'package:flutter/material.dart';

//Show dialog de busca
class SearchDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            top: 2,
            left: 6,
            right: 6,
            child: Card(
                child: TextFormField(
              textInputAction: TextInputAction.search,
              autofocus: true,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 15),
                prefixIcon: IconButton(
                    icon: Icon(Icons.arrow_back),
                    color: Colors.grey[800],
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
              ),
              onFieldSubmitted: (text) {
                Navigator.of(context).pop(text);
              },
            )))
      ],
    );
  }
}
