import 'package:custom_feedback/custom_feedback.dart';
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
        children: <Widget>[
          MainHeader(
            title: Row(
              spacing: 10,
              mainAxisAlignment: .center,
              children: <Widget>[
                const Text(
                  "Calculadora de Peso",
                  style: TextStyle(
                    color: AppThemes.whitePremium,
                    fontWeight: .bold,
                    fontSize: 18,
                  ),
                ),
                IconButton(
                  onPressed: _dialog,
                  icon: const Icon(
                    Icons.help_rounded,
                    color: AppThemes.whitePremium,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 25),
          InputNumber(
            controller: _textController,
            label: "Insira seu peso",
            isPlanetSelected: _calculatorService.isPlanetSelected(),
            onFieldSubmitted: _setState,
          ),
          const SizedBox(height: 10),
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
            const SizedBox(height: 20),
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

  void _dialog() {
    CustomFeedback.rawDialog(
      context: context,
      title: const Text(
        "Cálculo",
        style: TextStyle(color: AppThemes.blue1, fontWeight: .bold),
      ),
      closeIcon: true,
      iconColor: AppThemes.blue1,
      content: Column(
        mainAxisSize: .min,
        children: <Widget>[
          const Text(
            "M = Massa corporal\nG = Gravidade em relação a Terra\n"
            "Peso = M * G\n\n"
            "Exemplo:\nM = 70kg | G = 0.90\nM * G = 63kg",
            style: TextStyle(color: AppThemes.blue1),
          ),
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