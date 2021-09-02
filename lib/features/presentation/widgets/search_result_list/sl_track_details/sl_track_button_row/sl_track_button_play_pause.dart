import 'package:flutter/material.dart';
import 'package:flutter_music_player/features/data/models/track_item.dart';
import 'package:flutter_music_player/features/presentation/redux/appstate.dart';
import 'package:flutter_music_player/features/presentation/widgets/search_result_list/sl_track_details/sl_track_button_row/audio_player_wrapper.dart';
import 'package:flutter_redux/flutter_redux.dart';

class SlTrackButtonPlayPause extends StatelessWidget {
  final TrackItem _trackItem;

  SlTrackButtonPlayPause(this._trackItem);

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