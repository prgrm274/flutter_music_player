import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music_player/features/data/datasources/rest.dart';
import 'package:flutter_music_player/features/presentation/redux/actions.dart';
import 'package:flutter_music_player/features/presentation/widgets/search_result/albumdetail.dart';
import 'package:flutter_music_player/features/presentation/redux/appstate.dart';
import 'package:flutter_music_player/features/presentation/widgets/search_result/apptectsbutton.dart';
import 'package:flutter_music_player/features/presentation/widgets/audioplayerwrapper.dart';
import 'package:flutter_music_player/core/helper/helper.dart';
import 'package:flutter_music_player/features/presentation/widgets/search_dialog/searchdialog.dart';
import 'package:flutter_music_player/features/data/models/trackitem.dart';
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
              appBar:
                  AppBar(title: Text(widget.title), leading: ApptectsButton()),
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
              floatingActionButton: _SearchButton());
        });
  }
}

class _SearchButton extends StatelessWidget {
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

class _SearchResultList extends StatelessWidget {
  final List<TrackItem> _trackItems;

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
                    _TrackArtwork(trackItem.imageUrl),
                    _TrackDetails(trackItem),
                  ]),
            );
          },
        ),
        // _TrackButtonRow(trackItem)
      ],
    );
  }

  TrackItem trackItem;
  int posisi;
}

class _TrackButtonRow extends StatelessWidget {
  final TrackItem _trackItem;

  _TrackButtonRow(this._trackItem);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Store<AppState>>(
        converter: (store) => store,
        builder: (_, store) {
          final isPlaying =
              store.state.activePlayingAudioUrl == _trackItem.audioPreviewUrl;

          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _TrackButtonOpenUrl(_trackItem.trackViewUrl),
              _TrackButtonShowAlbumDetails(_trackItem),
              _TrackButtonPlayPause(_trackItem),
              _TrackDurationDisplay(store.state.currentAudioDuration, isPlaying)
            ],
          );
        });
  }
}

class _TrackButtonOpenUrl extends StatelessWidget {
  final String _trackUrl;

  _TrackButtonOpenUrl(this._trackUrl);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.link),
        color: Theme.of(context).buttonColor,
        iconSize: 20,
        onPressed: () => openUrl(_trackUrl));
  }
}

class _TrackButtonShowAlbumDetails extends StatelessWidget {
  final TrackItem _trackItem;

  _TrackButtonShowAlbumDetails(this._trackItem);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.dehaze),
        color: Theme.of(context).buttonColor,
        iconSize: 20,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AlbumDetail(_trackItem)));
        });
  }
}

class _TrackButtonPlayPause extends StatelessWidget {
  final TrackItem _trackItem;

  _TrackButtonPlayPause(this._trackItem);

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final isPlaying =
        store.state.activePlayingAudioUrl == _trackItem.audioPreviewUrl;

    return IconButton(
        icon: Icon(
            isPlaying ? Icons.pause_circle_outline : Icons.play_circle_outline),
        color: Theme.of(context).buttonColor,
        iconSize: 20,
        onPressed: () {
          if (!isPlaying) {
            AudioPlayerWrapper().playTrack(_trackItem.audioPreviewUrl);
          } else {
            AudioPlayerWrapper().stopTrack();
          }
        });
  }
}

class _TrackDurationDisplay extends StatelessWidget {
  final Duration _currentDuration;
  final bool _isPlaying;

  _TrackDurationDisplay(this._currentDuration, this._isPlaying);

  @override
  Widget build(BuildContext context) {
    var durationMinutes =
        (_currentDuration.inSeconds / 60).round().toString().padLeft(2, '0');
    var durationSeconds =
        (_currentDuration.inSeconds % 60).toString().padLeft(2, '0');

    return Text(_isPlaying ? '$durationMinutes:$durationSeconds' : '',
        textScaleFactor: 0.8, style: TextStyle(fontWeight: FontWeight.bold));
  }
}

class _TrackDetails extends StatelessWidget {
  final TrackItem _trackItem;

  _TrackDetails(this._trackItem);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      height: 120,
      padding: EdgeInsets.all(5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_trackItem.artistName,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold)),
          Text(
            _trackItem.albumName,
            overflow: TextOverflow.ellipsis,
            textScaleFactor: 0.8,
          ),
          Padding(padding: EdgeInsets.all(5.0)),
          Text(_trackItem.trackName, overflow: TextOverflow.ellipsis),

          /// Play & Pause
          Expanded(
            child: _TrackButtonRow(_trackItem),
          )
        ],
      ),
    ));
  }
}

class _TrackArtwork extends StatelessWidget {
  final String _imageUrl;

  _TrackArtwork(this._imageUrl);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 100,
        padding: EdgeInsets.all(5.0),
        child: Column(children: [
          CachedNetworkImage(
            imageUrl: _imageUrl,
            placeholder: (context, url) => new CircularProgressIndicator(),
            errorWidget: (context, url, error) => new Icon(Icons.error),
          )
        ]));
  }
}

class _TrackPrice extends StatelessWidget {
  final String _price;

  _TrackPrice(this._price);

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
