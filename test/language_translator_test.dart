// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:language_translator/main.dart';

void main() {
  testWidgets('Test language translator main screen', (WidgetTester tester) async {
    const textFieldOriginKey = Key('TextFieldOrigin');
    const textFieldDestinationKey = Key('TextFieldDestination');
    const dropDownOriginKey = Key('DropDownOrigin');
    const dropDownDestinationKey = Key('DropDownDestination');

    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that source text field is present.
    Finder originTextField = find.byKey(textFieldOriginKey);
    expect(originTextField, findsOneWidget);
    // Verify that destination text field is present.
    Finder destinationTextField = find.byKey(textFieldDestinationKey);
    expect(destinationTextField, findsOneWidget);
    // Verify that source language dropdown is present.
    Finder originDropDown = find.byKey(dropDownOriginKey);
    expect(originDropDown, findsOneWidget);
    // Verify that destination language dropdown is present.
    Finder destinationDropDown = find.byKey(dropDownDestinationKey);
    expect(destinationDropDown, findsOneWidget);

    // //Verify if typing in origin text field is updating destination test field or not.
    // await tester.enterText(originTextField, 'hello');
    // expect((destinationTextField.evaluate().single.widget as TextField).controller!.text, equals('नमस्ते'));
    //
    // //Verify if typing in destination text field is updating origin test field or not.
    // await tester.enterText(destinationTextField, 'नमस्ते');
    // expect((originTextField.evaluate().single.widget as TextField).controller!.text, equals('hello'));
  });
}
