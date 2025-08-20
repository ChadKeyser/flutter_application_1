import 'package:flutter/material.dart';

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
      if (value == '⌫') {
        if (_input.isNotEmpty) {
          _input = _input.substring(0, _input.length - 1);
        }
        _result = '';
      } else if (value == '=') {
        try {
          _result = _calculate(_input).toString();
        } catch (e) {
          _result = 'Error';
        }
      } else {
        _input += value;
      }
    });
  }

  double _calculate(String input) {
    String expr = input
        .replaceAll('÷', '/')
        .replaceAll('×', '*')
        .replaceAll('−', '-');
    final tokens = expr
        .split(RegExp(r'([+\-*/])'))
        .where((e) => e.isNotEmpty)
        .toList();
    if (tokens.length < 3) return double.tryParse(tokens[0]) ?? 0;
    double num1 = double.tryParse(tokens[0]) ?? 0;
    String op = expr.replaceAll(RegExp(r'[0-9.]'), '')[0];
    double num2 = double.tryParse(tokens[2]) ?? 0;
    switch (op) {
      case '+':
        return num1 + num2;
      case '-':
        return num1 - num2;
      case '*':
        return num1 * num2;
      case '/':
        return num2 != 0 ? num1 / num2 : double.nan;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
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
      '0',
      '⌫',
      '=',
      '+',
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Calculator')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.centerRight,
            child: Text(_input, style: const TextStyle(fontSize: 32)),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.centerRight,
            child: Text(
              _result,
              style: const TextStyle(fontSize: 24, color: Colors.green),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 1.2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: buttons.length,
              itemBuilder: (context, index) {
                final value = buttons[index];
                return ElevatedButton(
                  onPressed: () => _onPressed(value),
                  child: Text(value, style: const TextStyle(fontSize: 24)),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
