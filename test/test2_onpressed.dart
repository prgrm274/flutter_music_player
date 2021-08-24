
import 'package:flutter/material.dart';
import 'package:flutter_idea_20200720_1020/ui/main.dart';
import 'package:flutter_test/flutter_test.dart';

main(){
  testWidgets('notify when button is pressed', (WidgetTester tester) async {
    var pressed = false;
    final testWidget = MaterialApp(
      home: Main(
        onPressed: () => pressed = true,
      ),
    );

    await tester.pumpWidget(testWidget);
    await tester.pumpAndSettle();

    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    expect(pressed, isTrue);
  });
}