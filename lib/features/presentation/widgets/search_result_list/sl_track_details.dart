import 'package:flutter/material.dart';
import 'package:flutter_music_player/features/data/models/track_item.dart';
import 'package:flutter_music_player/features/presentation/widgets/search_result_list/sl_track_details/sl_track_button_row.dart';

class SlTrackDetails extends StatelessWidget {
  final TrackItem _trackItem;

  SlTrackDetails(this._trackItem);

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
                child: SlTrackButtonRow(_trackItem),
                // child: _TrackButtonRow(_trackItem),
              )
            ],
          ),
        ));
  }
}