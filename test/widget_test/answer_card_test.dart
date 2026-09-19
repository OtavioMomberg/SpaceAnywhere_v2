import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:space_anywhere/features/quiz/presentation/widgets/answer_card.dart';

void main() {
  testWidgets("verify onTap function", (tester) async {
    final rightAnswerIndex = 1;
    bool isCorrect = false;
    bool isScreenClosed = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AnswerCard(
            index: 1,
            option: "Answer 1",
            onTap: ({required int index}) async {
              isCorrect = (index == rightAnswerIndex);

              // simulates the process of closing the ResultScreen
              await Future.delayed(const Duration(milliseconds: 200));
              isScreenClosed = true;
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text("Answer 1"));

    expect(isCorrect, isTrue);
    expect(isScreenClosed, isFalse);

    await tester.pumpAndSettle();

    expect(isScreenClosed, isTrue);
  });
}