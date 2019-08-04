import 'package:flutter_test/flutter_test.dart';
import 'package:ripple_button/ripple_button.dart';

void main() {
  test('text', () {
    final button = RippleButton(text: "Test");
    expect(button.height, 48);
  });
}
