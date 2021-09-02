import 'package:flutter/material.dart';

class SlTrackPrice extends StatelessWidget {
  final String _price;

  SlTrackPrice(this._price);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(5.0),
        height: 120,
        width: 80,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_price,
                  textScaleFactor: 1.5,
                  style: TextStyle(fontWeight: FontWeight.bold))
            ]));
  }
}
