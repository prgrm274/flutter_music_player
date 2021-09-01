import 'package:flutter/material.dart';

class SlTrackDurationDisplay extends StatelessWidget {
  final Duration _currentDuration;
  final bool _isPlaying;

  SlTrackDurationDisplay(this._currentDuration, this._isPlaying);

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