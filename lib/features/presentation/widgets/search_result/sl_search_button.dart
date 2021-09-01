import 'package:flutter/material.dart';
import 'package:flutter_music_player/features/presentation/widgets/search_dialog/searchdialog.dart';

class SlSearchButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.search),
      foregroundColor: Theme.of(context).buttonColor,
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: () => _searchPressed(context),
    );
  }

  _searchPressed(BuildContext context) {
    showDialog(context: context, builder: (context) => SearchDialog());
  }
}