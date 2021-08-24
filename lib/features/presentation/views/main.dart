import 'package:flutter/material.dart';
import 'package:flutter_music_player/features/presentation/redux/appstate.dart';
import 'package:flutter_music_player/features/presentation/views/flutteritunesapp.dart';
import 'package:flutter_music_player/features/presentation/redux/reducer.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

Store<AppState> store;

void main() {
  store = Store<AppState>(
      reducer,
      initialState: AppState.initial(),
      middleware: [thunkMiddleware]
  );

  // runApp(ShowBottomSheet());
  // runApp(Snackbar());
  runApp(FlutteriTunesApp(store));
}
