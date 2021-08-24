import 'package:flutter/material.dart';

class Snackbar extends StatefulWidget {
  Snackbar({Key key}) : super(key: key);

  @override
  _SnackbarState createState() => _SnackbarState();
}

class _SnackbarState extends State<Snackbar> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: SnackBar(
            content: Text('Email deleted'),
            action: SnackBarAction(
              label: 'Undo',
              textColor: Colors.white,
              onPressed: () {},
            ),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            backgroundColor: Colors.blue,
          ),
        ),
      ),
    );
  }
}