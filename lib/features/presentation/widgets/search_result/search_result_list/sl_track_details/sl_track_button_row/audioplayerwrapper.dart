import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_music_player/features/presentation/redux/actions.dart';
import 'package:flutter_music_player/features/data/repositories_as_data_layer/audiodownloader.dart';
import 'package:flutter_music_player/features/presentation/views/main.dart';

class AudioPlayerWrapper {
  static final AudioPlayerWrapper _singleton = new AudioPlayerWrapper._internal();

  final _audioPlayer = AudioPlayer();
  final _audioDownloader = AudioDownloader();

  factory AudioPlayerWrapper() {
    return _singleton;
  }

  AudioPlayerWrapper._internal() {
    _audioPlayer.onAudioPositionChanged.listen(_onAudioDurationChange);
    _audioPlayer.onPlayerStateChanged.listen(_onAudioPlayerStateChange);
  }

  playTrack(String url) async {
    var previewFilename = await _audioDownloader.downloadUrl(url);
    await _audioPlayer.play(previewFilename, isLocal: true);

    store.dispatch(PlayAudioUrlAction(url));
  }

  stopTrack() async {
    await _audioPlayer.stop();
    store.dispatch(StopAudioAction());
  }

  _onAudioDurationChange(Duration duration) {
    store.dispatch(AudioDurationChangedAction(duration));
  }

  _onAudioPlayerStateChange(PlayerState state) {
    if(state == PlayerState.COMPLETED) {
      store.dispatch(CompletedAudioAction());
    }
  }

  // _onAudioPlayerStateChange(AudioPlayerState state) {
  //   if(state == AudioPlayerState.COMPLETED) {
  //     store.dispatch(CompletedAudioAction());
  //   }
  // }
}