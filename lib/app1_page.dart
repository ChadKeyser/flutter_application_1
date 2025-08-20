import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class App1Page extends StatefulWidget {
  const App1Page({super.key});

  @override
  State<App1Page> createState() => _App1PageState();
}

class _App1PageState extends State<App1Page> {
  String _input = '';
  String _result = '';

  void _onPressed(String value) {
    setState(() {
      if (value == 'C') {
        _input = '';
        _result = '';
        return;
      }

      if (value == '⌫') {
        if (_input.isNotEmpty) {
          _input = _input.substring(0, _input.length - 1);
        }
        _result = '';
        return;
      }

      if (value == '=') {
        _result = _calculate(_input);
        return;
      }

      if (value == '.') {
        // Prevent multiple decimals in the current (last) number
        final expr = _input
            .replaceAll('÷', '/')
            .replaceAll('×', '*')
            .replaceAll('−', '-');
        final parts = expr.split(RegExp(r'[+\-*/]'));
        final last = parts.isNotEmpty ? parts.last : '';
        if (last.contains('.')) {
          return; // ignore duplicate decimal
        }
      }

      // Append normal input (numbers/operators)
      _input += value;
    });
  }

  String _formatResult(double value) {
    if (value.isNaN || value.isInfinite) return 'Error';
    if (value == value.roundToDouble()) return value.toInt().toString();
    // Trim trailing zeros for fractional numbers
    String s = value.toString();
    // Remove trailing zeros after decimal
    if (s.contains('.')) {
      s = s.replaceFirst(RegExp(r'\.?0+$'), '');
    }
    return s;
  }

  String _calculate(String input) {
    String expr = input
        .replaceAll('÷', '/')
        .replaceAll('×', '*')
        .replaceAll('−', '-');

    try {
      Parser p = Parser();
      Expression exp = p.parse(expr);
      ContextModel cm = ContextModel();
      // Use EvaluationType.REAL or Evaluation.REAL depending on package version
      final eval = exp.evaluate(EvaluationType.REAL, cm);
      // eval is num/double
      if (eval is num) {
        return _formatResult(eval.toDouble());
      } else {
        return 'Error';
      }
    } catch (e) {
      return 'Error';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculator')),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final w = constraints.maxWidth;
            final h = constraints.maxHeight;
            final isNarrow = w < 360;
            final crossAxis = isNarrow ? 3 : 4;
            final buttonFont = isNarrow ? 20.0 : 24.0;
            final inputFont = isNarrow ? 28.0 : 32.0;
            final resultFont = isNarrow ? 18.0 : 24.0;

            final buttons = [
              '7',
              '8',
              '9',
              '÷',
              '4',
              '5',
              '6',
              '×',
              '1',
              '2',
              '3',
              '−',
              '.',
              '0',
              '=',
              '+',
            ];

            return Column(
              children: [
                // Display area - scales text to available width
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: w * 0.04,
                    vertical: h * 0.02,
                  ),
                  alignment: Alignment.centerRight,
                  height: h * 0.18,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerRight,
                        child: Text(
                          _input.isEmpty ? '0' : _input,
                          maxLines: 1,
                          style: TextStyle(fontSize: inputFont),
                        ),
                      ),
                      const SizedBox(height: 6),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerRight,
                        child: Text(
                          _result,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: resultFont,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Buttons grid - square buttons via AspectRatio
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: w * 0.03),
                    child: GridView.builder(
                      itemCount: buttons.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxis,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 1, // square buttons
                      ),
                      itemBuilder: (context, index) {
                        final value = buttons[index];
                        return AspectRatio(
                          aspectRatio: 1,
                          child: ElevatedButton(
                            onPressed: () => _onPressed(value),
                            child: Text(
                              value,
                              style: TextStyle(fontSize: buttonFont),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // Bottom bar with single backspace button (responsive height)
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: w * 0.04,
                    vertical: h * 0.015,
                  ),
                  child: SizedBox(
                    height: isNarrow ? 48 : 56,
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => _onPressed('⌫'),
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Icon(
                              Icons.backspace,
                              size: isNarrow ? 20 : 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
