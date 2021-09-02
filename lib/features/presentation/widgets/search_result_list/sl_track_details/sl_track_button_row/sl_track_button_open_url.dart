import 'package:flutter/material.dart';
import 'package:flutter_music_player/core/helper/helper.dart';

class SlTrackButtonOpenUrl extends StatelessWidget {
  final String _trackUrl;

  SlTrackButtonOpenUrl(this._trackUrl);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.link),
        color: Theme.of(context).buttonColor,
        iconSize: 20,
        onPressed: () => openUrl(_trackUrl));
  }
}
