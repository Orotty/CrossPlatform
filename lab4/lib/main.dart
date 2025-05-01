import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _formKey = GlobalKey<FormBuilderState>();
  String? _validationMessage;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: FormBuilder(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FormBuilderTextField(
                  name: 'color',
                  decoration: InputDecoration(labelText: 'HEX-код кольору'),
                  validator: (value) {
                    final hexPattern = RegExp(r'^#([A-Fa-f0-9]{6})$');
                    if (value == null || !hexPattern.hasMatch(value)) {
                      return 'Невірний HEX-код (приклад: #AABBCC)';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    final isValid = _formKey.currentState?.saveAndValidate() ?? false;
                    setState(() {
                      _validationMessage = isValid ? 'Дані коректні!' : 'Форма містить помилки.';
                    });
                  },
                  child: Text('Перевірити'),
                ),
                if (_validationMessage != null) ...[
                  SizedBox(height: 20),
                  Text(
                    _validationMessage!,
                    style: TextStyle(
                      color: _validationMessage == 'Дані коректні!' ? Colors.green : Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
