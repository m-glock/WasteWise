import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';
import 'package:recycling_app/presentation/pages/profile/widgets/TextInputWidget.dart';

class RegistrationWidget extends StatefulWidget {
  const RegistrationWidget({Key? key}) : super(key: key);

  @override
  State<RegistrationWidget> createState() => _RegistrationWidgetState();
}

class _RegistrationWidgetState extends State<RegistrationWidget> {
  final TextEditingController controllerUsername = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  final TextEditingController controllerEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextInputWidget(
                  controller: controllerUsername,
                  label: 'Username',
                  inputType: TextInputType.text),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextInputWidget(
                  controller: controllerEmail,
                  label: 'E-Mail',
                  inputType: TextInputType.emailAddress),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextInputWidget(
                  isPassword: true,
                  controller: controllerPassword,
                  label: 'Password',
                  inputType: TextInputType.text),
            ),
            ElevatedButton(
              child: const Text('Sign Up'),
              onPressed: () => doUserRegistration(),
            ),
          ],
        ),
      ),
    );
  }

  void _showSuccess() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Success!"),
          content: const Text("User was successfully created!"),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showError(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error!"),
          content: Text(errorMessage),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void doUserRegistration() async {
    // get values from the text fields
    final String username = controllerUsername.text.trim();
    final String email = controllerEmail.text.trim();
    final String password = controllerPassword.text.trim();

    // create user
    final ParseUser user = ParseUser.createUser(username, password, email);
    final ParseResponse response = await user.signUp();

    // handle response from server
    if (response.success) {
      //TODO is registered user already authenticated?
      _showSuccess();
    } else {
      _showError(response.error!.message);
    }
  }
}
