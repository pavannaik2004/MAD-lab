import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DemoPage(),
    );
  }
}

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final ageController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    ageController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  void _submit() {
    final values = {
      'Name': nameController.text,
      'Email': emailController.text,
      'Age': ageController.text,
      'Password': passwordController.text,
    };
    // Validate age: must parse and be below 100 (if provided)
    final ageText = ageController.text;
    if (ageText.isNotEmpty) {
      final age = int.tryParse(ageText);
      if (age == null || age >= 100) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter a valid age below 100')),
        );
        return;
      }
    }

    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Submitted values'),
        content: SingleChildScrollView(
          child: ListBody(
            children: values.entries
                .map((e) => Text('${e.key}: ${e.value}'))
                .toList(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    String? hint,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    bool obscure = false,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: const OutlineInputBorder(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TextField Demo')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Flutter TextField examples',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              _buildField(
                controller: nameController,
                label: 'Name',
                hint: 'No digits allowed',
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'[0-9]')),
                ],
              ),
              const SizedBox(height: 12),

              _buildField(
                controller: emailController,
                label: 'Email',
                hint: 'Type an email',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 12),

              _buildField(
                controller: ageController,
                label: 'Age',
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  LengthLimitingTextInputFormatter(3),
                ],
              ),
              const SizedBox(height: 12),

              _buildField(
                controller: passwordController,
                label: 'Password',
                hint: 'Hidden',
                obscure: true,
              ),
              const SizedBox(height: 8),
              const SizedBox(height: 8),

              // (username, phone and credit card fields removed as requested)
              const SizedBox(height: 16),

              ElevatedButton(onPressed: _submit, child: const Text('Submit')),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
