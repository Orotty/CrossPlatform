import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Форма введення даних + Секундомір')),
        body: InputForm(),
      ),
    );
  }
}

class InputForm extends StatefulWidget {
  @override
  _InputFormState createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  final TextEditingController _controller = TextEditingController();
  String _output = '';
  int _seconds = 0;
  bool _isRunning = false;
  Timer? _timer;

  void _handleSubmit() {
    setState(() {
      _output = 'Ви ввели: ' + _controller.text;
    });
  }

  void _toggleTimer() {
    if (_isRunning) {
      _timer?.cancel();
    } else {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          _seconds++;
        });
      });
    }
    setState(() {
      _isRunning = !_isRunning;
    });
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _seconds = 0;
      _isRunning = false;
    });
  }

  String _formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return "$minutes:$secs";
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: InputDecoration(labelText: 'Введіть текст'),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: _handleSubmit,
            child: Text('Відправити'),
          ),
          SizedBox(height: 20),
          Text(_output, style: TextStyle(fontSize: 18)),
          Divider(height: 40, thickness: 2),
          Text(
            'Секундомір: ${_formatTime(_seconds)}',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _toggleTimer,
                child: Text(_isRunning ? 'Стоп' : 'Старт'),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: _resetTimer,
                child: Text('Скинути'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
