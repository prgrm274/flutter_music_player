import 'package:flutter/material.dart';
import 'package:flutter_music_player/features/data/models/trackitem.dart';
import 'package:flutter_music_player/features/presentation/redux/appstate.dart';
import 'package:flutter_music_player/features/presentation/widgets/search_result/search_result_list/sl_track_details/sl_track_button_row/sl_track_button_open_url.dart';
import 'package:flutter_music_player/features/presentation/widgets/search_result/search_result_list/sl_track_details/sl_track_button_row/sl_track_button_play_pause.dart';
import 'package:flutter_music_player/features/presentation/widgets/search_result/search_result_list/sl_track_details/sl_track_button_row/sl_track_button_show_album_details.dart';
import 'package:flutter_music_player/features/presentation/widgets/search_result/search_result_list/sl_track_details/sl_track_button_row/sl_track_duration_display.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

/// private before
class SlTrackButtonRow extends StatelessWidget {
  final TrackItem _trackItem;

  SlTrackButtonRow(this._trackItem);

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
              SlTrackButtonOpenUrl(_trackItem.trackViewUrl),
              SlTrackButtonShowAlbumDetails(_trackItem),
              SlTrackButtonPlayPause(_trackItem),
              SlTrackDurationDisplay(store.state.currentAudioDuration, isPlaying)
              // _TrackButtonOpenUrl(_trackItem.trackViewUrl),
              // _TrackButtonShowAlbumDetails(_trackItem),
              // _TrackButtonPlayPause(_trackItem),
              // _TrackDurationDisplay(store.state.currentAudioDuration, isPlaying)
            ],
          );
        });
  }
}