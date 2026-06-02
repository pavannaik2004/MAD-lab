import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  // runApp() starts the Flutter application and shows the first widget on screen.
  runApp(MyApp());
}

// StatefulWidget is used here because we keep text input in controllers.
class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // A TextEditingController holds the text for one TextField.
  // We create one controller per field so we can read each value later.
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController creditCardController = TextEditingController();

  @override
  void dispose() {
    // dispose() removes the controllers from memory when this screen closes.
    // This is important because controllers are objects that keep state alive.
    nameController.dispose();
    emailController.dispose();
    ageController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    phoneController.dispose();
    creditCardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Hides the red debug banner in the top-right corner.
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // Scaffold gives the page a basic Material Design layout.
        appBar: AppBar(title: const Text("TextField Example")),
        body: Padding(
          // Adds empty space around the content so it does not touch the edges.
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            // Lets the page scroll if the keyboard makes the screen shorter.
            child: Column(
              // Stretch the children so text fields use the full width.
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  "Flutter TextField Demo",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                // Name field example:
                // - hintText shows grey helper text before typing
                // - labelText moves above the field when focused
                // - border gives the field a visible outline
                TextField(
                  controller: nameController,
                  // deny() blocks digits, so the user cannot type numbers here.
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp(r'[0-9]')),
                  ],
                  decoration: const InputDecoration(
                    hintText: "Enter your name",
                    labelText: "Name",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                // Email field example:
                // keyboardType changes the keyboard layout on the phone.
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    hintText: "Enter your email",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                // Age field example:
                // allow() permits only digits, and length limiting keeps input short.
                TextField(
                  controller: ageController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    LengthLimitingTextInputFormatter(3),
                  ],
                  decoration: const InputDecoration(
                    labelText: "Age",
                    hintText: "Enter your age",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                // Password field example:
                // obscureText hides the characters so other people cannot read them.
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Password",
                    hintText: "Enter your password",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),

                // This heading separates the basic TextField examples from formatter examples.
                const Text(
                  "Input formatters",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),

                // Username example:
                // deny(RegExp(r'[0-9]')) blocks digits.
                // LengthLimitingTextInputFormatter(10) stops typing after 10 characters.
                TextField(
                  controller: usernameController,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp(r'[0-9]')),
                    LengthLimitingTextInputFormatter(10),
                  ],
                  decoration: const InputDecoration(
                    labelText: "Username",
                    hintText: "No digits, max 10 characters",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                // Phone number example:
                // allow(RegExp(r'[0-9]')) means only digits can be entered.
                // The length limit is useful because phone numbers are usually short.
                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    LengthLimitingTextInputFormatter(10),
                  ],
                  decoration: const InputDecoration(
                    labelText: "Phone Number",
                    hintText: "Only digits, max 10",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                // Credit card example:
                // The pattern [0-9 -] allows digits, spaces, and hyphens.
                // This is useful for typed card numbers like 1234 5678 9012 3456.
                TextField(
                  controller: creditCardController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9 -]')),
                    LengthLimitingTextInputFormatter(19),
                  ],
                  decoration: const InputDecoration(
                    labelText: "Credit Card",
                    hintText: "Digits, spaces, and hyphens",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () {
                    // debugPrint() sends the values to the console so you can inspect them.
                    // In a real app, you might validate the data or send it to a server.
                    debugPrint("Name: ${nameController.text}");
                    debugPrint("Email: ${emailController.text}");
                    debugPrint("Age: ${ageController.text}");
                    debugPrint("Password: ${passwordController.text}");
                    debugPrint("Username: ${usernameController.text}");
                    debugPrint("Phone: ${phoneController.text}");
                    debugPrint("Credit Card: ${creditCardController.text}");

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Input submitted")),
                    );
                  },
                  child: const Text("Submit"),
                ),
                const SizedBox(height: 20),

                // These notes summarize the keyboard types used above.
                const Text(
                  "Common keyboard types:\n"
                  "- TextInputType.text: normal text keyboard\n"
                  "- TextInputType.number: numeric keyboard\n"
                  "- TextInputType.phone: phone keypad\n"
                  "- TextInputType.emailAddress: email keyboard\n"
                  "- TextInputType.url: URL keyboard",
                ),
                const SizedBox(height: 20),

                // These notes explain what each formatter does in simple words.
                const Text(
                  "Input formatter ideas:\n"
                  "- deny(RegExp(r'[0-9]')) blocks digits\n"
                  "- allow(RegExp(r'[0-9]')) allows only digits\n"
                  "- LengthLimitingTextInputFormatter(10) stops after 10 characters\n"
                  "- allow(RegExp(r'[0-9 -]')) is useful for credit card input",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
