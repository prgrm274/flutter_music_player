import 'package:flutter/material.dart';
import 'package:flutter_music_player/features/data/models/trackitem.dart';
import 'package:flutter_music_player/features/presentation/widgets/search_result/search_result_list/sl_track_details/sl_track_button_row/albumdetail.dart';

class SlTrackButtonShowAlbumDetails extends StatelessWidget {
  final TrackItem _trackItem;

  SlTrackButtonShowAlbumDetails(this._trackItem);

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