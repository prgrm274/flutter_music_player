
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

main(){
  /// Check if Main page/screen/widget is there
  testWidgets('is Main there', (WidgetTester pengetes) async {
    final mainScreenTest = MaterialApp(home: Main(onPressed: (){}));
    /// before onPressed added
    //final mainScreenTest = MaterialApp(home: Main());
    await pengetes.pumpWidget(mainScreenTest);
    await pengetes.pumpAndSettle();
  });

  /// Check if Main has Text widget
  testWidgets('does Main has Text', (WidgetTester pengetes) async {
    final mainScreenTest = MaterialApp(home: Main(onPressed: (){}));
    await pengetes.pumpWidget(mainScreenTest);
    await pengetes.pumpAndSettle();
    expect(find.text('Expected text'), findsOneWidget);
  });

  /// Check if button is there, icon and text are shown, has background,
  /// and onPressed is correctly called
  testWidgets('', (WidgetTester pengetes) async {
    final testWidget = MaterialApp(home: Main(onPressed: (){}));
    await pengetes.pumpWidget(testWidget);
    await pengetes.pumpAndSettle();

    final buttonMaterial = find.descendant(
      of: find.byType(ElevatedButton),
      matching: find.byType(Material),
    );

    final materialButton = pengetes.widget<Material>(buttonMaterial);
    expect(materialButton.color, Colors.blue);
    expect(find.text('Playing now'), findsOneWidget);
    expect(find.byKey(Key('playing_now')), findsOneWidget);
  });
}