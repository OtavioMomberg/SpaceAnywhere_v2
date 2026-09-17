import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:space_anywhere/shared/widgets/check_connection.dart';
import 'package:space_anywhere/shared/widgets/info_error_widget.dart';

void main() {
  group("Verify CheckConnection widget", () {
    testWidgets("check if loading is working", (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CheckConnection(
              isLoading: true, 
              checkInternet: true, 
              checkAPI: true, 
              height: 500
            )
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byIcon(Icons.wifi_off), findsNothing);
      expect(find.widgetWithText(InfoErrorWidget, "Erro. Não foi possível se conectar ao servidor"), findsNothing);
    }); 

    testWidgets("check loading state", (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CheckConnection(
              isLoading: true, 
              checkInternet: false, 
              checkAPI: true, 
              height: 500
            )
          ),
        ),
      );

      expect(find.text("Carregando..."), findsOneWidget);
      expect(find.text("Erro. Sem conexão com a internet"), findsNothing);

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CheckConnection(
              isLoading: false, 
              checkInternet: false, 
              checkAPI: true, 
              height: 500
            )
          ),
        ),
      );

      expect(find.text("Carregando..."), findsNothing);
      expect(find.text("Erro. Sem conexão com a internet"), findsOneWidget);
    }); 

    testWidgets("should render empty space when connection checks succeed", (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CheckConnection(
              isLoading: false, 
              checkInternet: true, 
              checkAPI: true, 
              height: 500
            )
          ),
        ),
      );

      expect(find.byType(SizedBox), findsOneWidget);
      expect(find.byType(Padding), findsNothing);
    }); 
  });
}