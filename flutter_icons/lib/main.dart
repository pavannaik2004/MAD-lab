// Core Flutter UI library.
import 'package:flutter/material.dart';
// Provides text input formatters and other platform services.
import 'package:flutter/services.dart';

// app entry point: runApp inflates the widget tree and attaches
// it to the screen. We pass our top-level `MyApp` widget here.
void main() => runApp(const MyApp());

// `MyApp` is a lightweight container for app-wide configuration.
// It returns a `MaterialApp` which provides Material Design
// theming, navigation, and other features.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // Remove the debug banner shown in the top-right corner.
      debugShowCheckedModeBanner: false,
      // Set the home screen to our demo page.
      home: DemoPage(),
    );
  }
}

// Stateful widget because we need to persist text entered into
// multiple TextFields. The mutable state (controllers, values)
// lives in `_DemoPageState`.
class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  // TextEditingController objects keep track of the current value
  // in a TextField. Use one controller per field so we can read
  // all values when the user submits the form.
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final ageController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // Controllers are disposable resources. Dispose them here to
    // avoid memory leaks when the widget is removed from the tree.
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
    // AGE VALIDATION:
    // If the user entered an age, parse it and ensure it's a number
    // below 100. If invalid, show a SnackBar and abort submission.
    final ageText = ageController.text;
    if (ageText.isNotEmpty) {
      final age = int.tryParse(ageText);
      if (age == null || age >= 100) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter a valid age below 100')),
        );
        return; // stop submission so user can correct the value
      }
    }

    // If validation passes, show a small dialog with the entered values.
    // In a real app you'd typically send these to a server or save them.
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Submitted values'),
        content: SingleChildScrollView(
          child: ListBody(
            children: values.entries.map((e) => Text('${e.key}: ${e.value}')).toList(),
          ),
        ),
        actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('OK'))],
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
    // Builds and returns a configured TextField widget. This keeps the
    // build() method more concise by centralizing common configuration.
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      obscureText: obscure,
      decoration: InputDecoration(labelText: label, hintText: hint, border: const OutlineInputBorder()),
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
              // Heading for the demo
              const Text('Flutter TextField examples', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),

              // NAME: block digits so the user's name contains only
              // letters and punctuation (no numbers).
              _buildField(
                controller: nameController,
                label: 'Name',
                hint: 'No digits allowed',
                inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'[0-9]'))],
              ),
              const SizedBox(height: 12),

              // EMAIL: present an email-optimized keyboard on mobile devices.
              _buildField(controller: emailController, label: 'Email', hint: 'Type an email', keyboardType: TextInputType.emailAddress),
              const SizedBox(height: 12),

              // AGE: numeric keyboard and input formatters. Here it allows
              // digits and limits maximum length. The runtime check in
              // `_submit()` ensures the value is below 100.
              _buildField(
                controller: ageController,
                label: 'Age',
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]')), LengthLimitingTextInputFormatter(3)],
              ),
              const SizedBox(height: 12),

              // PASSWORD: hides the typed characters for privacy.
              _buildField(controller: passwordController, label: 'Password', hint: 'Hidden', obscure: true),
              const SizedBox(height: 8),

              // (Other fields removed to keep this demo compact.)
              const SizedBox(height: 16),

              // Submit button triggers validation and displays entered values.
              ElevatedButton(onPressed: _submit, child: const Text('Submit')),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
