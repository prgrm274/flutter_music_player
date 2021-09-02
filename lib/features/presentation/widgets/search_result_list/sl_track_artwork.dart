import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// private before
class SlTrackArtwork extends StatelessWidget {
  final String _imageUrl;

  SlTrackArtwork(this._imageUrl);

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