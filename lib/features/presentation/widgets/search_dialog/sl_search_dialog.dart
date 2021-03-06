import 'package:flutter/material.dart';
import 'package:flutter_music_player/features/presentation/redux/actions.dart';
import 'package:flutter_music_player/features/presentation/redux/appstate.dart';
import 'package:flutter_music_player/features/data/datasources/rest.dart';
import 'package:flutter_redux/flutter_redux.dart';

/// OnSearchCallback
/// SearchDialog
/// _SearchDialogWidget
/// _SearchDialogWidgetState

typedef OnSearchCallback = Function(String searchText);

class SlSearchDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, OnSearchCallback>(
      converter: (store) {
        return (searchText) {
          store.dispatch(ChangeSearchTextAction(searchText));
          store.dispatch(getSearchResult);
        };
      },
      builder: (_, searchCallback) {
        return _SfulSearchDialog(searchCallback);
      }
    );
  }
}

class _SfulSearchDialog extends StatefulWidget {
  final OnSearchCallback _callback;
  _SfulSearchDialog(this._callback);

  @override
  State<StatefulWidget> createState() => _SfulSearchDialogState(_callback);
}

class _SfulSearchDialogState extends State<_SfulSearchDialog> {
  String _searchText;
  final OnSearchCallback _callback;
  _SfulSearchDialogState(this._callback);

  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      contentPadding: const EdgeInsets.all(16.0),
      content: new Row(
        children: [
          Expanded(
            child: TextField(
              textAlign: TextAlign.center,
              autofocus: true,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(color: Colors.blue)
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(color: Colors.yellowAccent)
                ),
                hintText: 'Search artist'
              ),
              onChanged: _handleTextChanged,
            ),
          )
        ],
      ),
      actions: [
        FlatButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.pop(context);
          }
        ),
        FlatButton(
          child: const Text('Search'),
          onPressed: () {
            Navigator.pop(context);
            _callback(_searchText);
          },
        )
      ],
    );
  }

  _handleTextChanged(String newSearchText) {
    setState(() {
      _searchText = newSearchText;
    });
  }
}