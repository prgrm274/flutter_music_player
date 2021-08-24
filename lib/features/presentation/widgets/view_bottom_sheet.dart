import 'package:flutter/material.dart';
import 'package:flutter_music_player/features/presentation/widgets/bottom_sheet_custom.dart';

class ShowBottomSheet extends StatefulWidget {
  ShowBottomSheet({Key key}) : super(key: key);

  @override
  _ShowBottomSheetState createState() => _ShowBottomSheetState();
}

class _ShowBottomSheetState extends State<ShowBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Text('text'),
        ),
        floatingActionButton: Builder(
          builder: (context) => FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                showModalBottomSheet<void>(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (BuildContext context) {
                    return BottomSheetCustom(
                      child: Column(
                        children: [
                          _buildListItem(
                            context,
                            title: Text('Total Task'),
                            leading: Icon(Icons.check_circle_outline),
                            trailing: Switch(
                              value: true,
                              onChanged: (value) {},
                            ),
                          ),
                          _buildListItem(
                            context,
                            title: Text('Due Soon'),
                            leading: Icon(Icons.inbox),
                            trailing: Switch(
                              value: false,
                              onChanged: (value) {},
                            ),
                          ),
                          _buildListItem(
                            context,
                            title: Text('Completed'),
                            leading: Icon(Icons.check_circle),
                            trailing: Switch(
                              value: false,
                              onChanged: (value) {},
                            ),
                          ),
                          _buildListItem(
                            context,
                            title: Text('Working On'),
                            leading: Icon(Icons.flag),
                            trailing: Switch(
                              value: false,
                              onChanged: (value) {},
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
                // showModalBottomSheet(
                //   context: context,
                //   builder: (context) {
                //     return Text('Modal bottom sheet', style: TextStyle(fontSize: 30));
                //   });
              }
          ),
        ),
      ),
    );
  }

  void _handleFABPressed() {
    showModalBottomSheet<int>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return BottomSheetCustom(
          child: Column(
            children: [
              _buildListItem(
                context,
                title: Text('Total Task'),
                leading: Icon(Icons.check_circle_outline),
                trailing: Switch(
                  value: true,
                  onChanged: (value) {},
                ),
              ),
              _buildListItem(
                context,
                title: Text('Due Soon'),
                leading: Icon(Icons.inbox),
                trailing: Switch(
                  value: false,
                  onChanged: (value) {},
                ),
              ),
              _buildListItem(
                context,
                title: Text('Completed'),
                leading: Icon(Icons.check_circle),
                trailing: Switch(
                  value: false,
                  onChanged: (value) {},
                ),
              ),
              _buildListItem(
                context,
                title: Text('Working On'),
                leading: Icon(Icons.flag),
                trailing: Switch(
                  value: false,
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildListItem(
      BuildContext context, {
        Widget title,
        Widget leading,
        Widget trailing,
      }) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 16.0,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: theme.dividerColor,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          if (leading != null) leading,
          if (title != null)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: DefaultTextStyle(
                child: title,
                style: theme.textTheme.headline6,
              ),
            ),
          Spacer(),
          if (trailing != null) trailing,
        ],
      ),
    );
  }
}