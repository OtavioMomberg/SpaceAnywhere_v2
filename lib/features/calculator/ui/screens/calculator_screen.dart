import 'package:material_ui/material_ui.dart';
import 'package:space_anywhere/features/calculator/domain/calculator_service.dart';
import 'package:space_anywhere/core/themes/app_themes.dart';
import 'package:space_anywhere/shared/widgets/button.dart';
import 'package:space_anywhere/shared/widgets/main_header.dart';
import 'package:space_anywhere/features/calculator/ui/widgets/calculator_widgets.dart';

class const CalculatorScreen({super.key}) extends StatefulWidget {
  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final _calculatorService = CalculatorService();
  final _textController = TextEditingController();
  final _expansibleController = ExpansibleController();

  @override
  void initState() {
    super.initState();
    _calculatorService.setDefaultText();
    _calculatorService.initializeResult();
    _expansibleController.expand();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        spacing: 10,
        children: <Widget>[
          const MainHeader(
            title: Text(
              "Calcule seu peso em outros planetas",
              style: TextStyle(
                color: AppThemes.whitePremium,
                fontWeight: .bold,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 20),
          InputNumber(
            controller: _textController,
            label: "Insira seu peso",
            isPlanetSelected: _calculatorService.isPlanetSelected(),
            onFieldSubmitted: _setState,
          ),
          ExpansibleWidget(
            header: ExpansibleHeader(
              controller: _expansibleController,
              calculatorService: _calculatorService,
            ),
            body: ExpansibleBody(
              controller: _expansibleController,
              calculatorService: _calculatorService,
              isWeightSet: _textController.text != "Insira seu peso",
              setState: _setState,
            ),
            controller: _expansibleController,
          ),
          if (_calculatorService.checkFields(weightText: _textController.text)) ...[
            const SizedBox(height: 10),
            Button(
              label: "Calcular",
              function: () {
                _calculatorService.calculate(weight: _textController.text);
                setState(() {});
              },
            ),
            if (_calculatorService.result != 0.0) ...[
              const SizedBox(height: 10),
              CalculusResult(calculatorService: _calculatorService),
              const SizedBox(height: 10),
              Button(label: "Limpar", function: _cleanScreen),
            ],
          ],
        ],
      ),
    );
  }

  void _setState() => setState(() {});

  void _cleanScreen() {
    _calculatorService.setDefaultText();
    _calculatorService.initializeResult();
    _textController.clear();
    setState(() {});
  }

  @override
  void dispose() {
    _textController.dispose();
    _expansibleController.dispose();
    super.dispose();
  }
}