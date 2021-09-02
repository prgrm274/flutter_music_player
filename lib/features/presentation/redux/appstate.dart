import 'package:flutter_music_player/features/data/models/track_item.dart';
import 'package:meta/meta.dart';

/// List<TrackItem>() is deprecated, replaced to List<TrackItem>.empty(growable: true)
@immutable
class AppState {
  final String searchText;
  final List<TrackItem> trackItems;
  final String activePlayingAudioUrl;
  final Duration currentAudioDuration;
  final int albumId;
  final List<TrackItem> albumItems;
  final DateTime albumReleaseDate;

  AppState({
    @required this.searchText,
    @required this.trackItems,
    @required this.activePlayingAudioUrl,
    @required this.currentAudioDuration,
    @required this.albumId,
    @required this.albumItems,
    @required this.albumReleaseDate
  });

  factory AppState.initial(){
    return AppState(
        searchText: '',
        trackItems: List<TrackItem>.empty(growable: true),
        activePlayingAudioUrl: '',
        currentAudioDuration: Duration(),
        albumId: 0,
        albumItems: List<TrackItem>.empty(growable: true),
        albumReleaseDate: DateTime.now()
    );
  }

  copyWith({
    String searchText,
    List<TrackItem> trackItems,
    String activePlayingAudioUrl,
    Duration currentAudioDuration,
    int albumId,
    List<TrackItem> albumItems,
    DateTime albumReleaseDate
  }) {
    return AppState(
        searchText: searchText ?? this.searchText,
        trackItems: trackItems != null
            ? (List<TrackItem>.empty(growable: true)..addAll(trackItems))
            : (List<TrackItem>.empty(growable: true)..addAll(this.trackItems)),
        activePlayingAudioUrl: activePlayingAudioUrl ?? this.activePlayingAudioUrl,
        currentAudioDuration: currentAudioDuration ?? this.currentAudioDuration,
        albumId: albumId ?? this.albumId,
        albumItems: albumItems != null
            ? (List<TrackItem>.empty(growable: true)..addAll(albumItems))
            : (List<TrackItem>.empty(growable: true)..addAll(this.albumItems)),
        albumReleaseDate: albumReleaseDate ?? this.albumReleaseDate
    );
  }
}