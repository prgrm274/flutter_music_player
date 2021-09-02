import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music_player/features/data/datasources/rest.dart';
import 'package:flutter_music_player/features/presentation/redux/actions.dart';
import 'package:flutter_music_player/features/presentation/redux/appstate.dart';
import 'package:flutter_music_player/features/presentation/widgets/not_list/sl_scaffold_leading.dart';
import 'package:flutter_music_player/features/presentation/widgets/not_list/sl_search_button.dart';
import 'package:flutter_music_player/core/helper/helper.dart';
import 'package:flutter_music_player/features/presentation/widgets/search_dialog/sl_search_dialog.dart';
import 'package:flutter_music_player/features/data/models/track_item.dart';
import 'package:flutter_music_player/features/presentation/widgets/search_result_list/sl_track_artwork.dart';
import 'package:flutter_music_player/features/presentation/widgets/search_result_list/sl_track_details.dart';
import 'package:flutter_music_player/features/presentation/widgets/search_result_list/sl_track_details/sl_track_button_row/albumdetail.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';


/*
Using:

_SearchButton
_SearchResultList
_TrackButtonRow
_TrackButtonOpenUrl
_TrackButtonShowAlbumDetails
_TrackButtonPlayPause
_TrackDurationDisplay
_TrackDetails
_TrackArtwork
_TrackPrice
 */

typedef OnSearchCallback = Function(String searchText);

class SearchResultList extends StatefulWidget {
  final String title;

  final OnSearchCallback callback;

  SearchResultList({Key key, this.title, this.callback}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchResultListState(callback);
// _SearchResultListState createState() => _SearchResultListState();
}

class _SearchResultListState extends State<SearchResultList> {
  /// Search
  String _searchText;
  final OnSearchCallback _callback;

  _SearchResultListState(this._callback);

  _handleTextChanged(String newSearchText) {
    setState(() {
      _searchText = newSearchText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, List<TrackItem>>(
        converter: (store) => store.state.trackItems,
        builder: (_, trackItems) {
          return Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                  title: Text(widget.title),
                  leading: SlScaffoldLeading()),
              body: Stack(
                children: [
                  Column(
                    children: [
                      /// Search
                      Container(
                        height: 100,
                        child: new StoreConnector<AppState, OnSearchCallback>(
                            converter: (store) {
                          return (searchText) {
                            store.dispatch(ChangeSearchTextAction(_searchText));
                            store.dispatch(getSearchResult);
                          };
                        }, builder: (_, searchCallback) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 40),
                            child: TextField(
                              textAlign: TextAlign.center,
                              autofocus: true,
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: Icon(Icons.search),
                                    onPressed: () {
                                      // searchCallback = _callback;///nope
                                      searchCallback(_searchText);
                                      // _callback(_searchText);///nope
                                    },
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)),
                                      borderSide:
                                          BorderSide(color: Colors.blue)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)),
                                      borderSide: BorderSide(
                                          color: Colors.yellowAccent)),
                                  hintText: 'Search artist'),
                              onChanged: _handleTextChanged,
                            ),
                          );
                        }),
                      ),

                      /// List
                      Expanded(child: _SearchResultList(trackItems)),
                    ],
                  ),
                ],
              ),
              // body: _SearchResultList(trackItems),
              floatingActionButton: SlSearchButton());
          // floatingActionButton: _SearchButton());
        });
  }
}

class _SearchResultList extends StatelessWidget {
  final List<TrackItem> _trackItems;

  TrackItem trackItem;
  int posisi;

  _SearchResultList(this._trackItems);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          itemCount: _trackItems.length,
          itemBuilder: (_, position) {
            // trackItem = _trackItems[position];
            // posisi = position;

            var trackItem = _trackItems[position];
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AlbumDetail(trackItem)));
              },
              child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SlTrackArtwork(trackItem.imageUrl),
                    // _TrackArtwork(trackItem.imageUrl),
                    SlTrackDetails(trackItem),
                    // _TrackDetails(trackItem),
                  ]),
            );
          },
        ),
        // _TrackButtonRow(trackItem)
      ],
    );
  }
}

// class _SearchButton extends StatelessWidget {}

///
///

// class _TrackButtonRow extends StatelessWidget {}

// class _TrackButtonOpenUrl extends StatelessWidget {}

// class _TrackButtonShowAlbumDetails extends StatelessWidget {}

// class _TrackButtonPlayPause extends StatelessWidget {}

// class _TrackDurationDisplay extends StatelessWidget {}

// class _TrackDetails extends StatelessWidget {}

// class _TrackArtwork extends StatelessWidget {}

// class _TrackPrice extends StatelessWidget {}
