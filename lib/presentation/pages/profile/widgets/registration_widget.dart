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
                  label: Languages.of(context)!.usernameLabel,
                  inputType: TextInputType.text),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextInputWidget(
                  controller: controllerEmail,
                  label: Languages.of(context)!.emailLabel,
                  inputType: TextInputType.emailAddress),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextInputWidget(
                  isPassword: true,
                  controller: controllerPassword,
                  label: Languages.of(context)!.passwordLabel,
                  inputType: TextInputType.text),
            ),
            ElevatedButton(
              child: Text(Languages.of(context)!.signupButtonText),
              onPressed: () => doUserRegistration(),
            ),
            TextButton(
              child: Text(Languages.of(context)!.goToLoginButtonText),
              onPressed: () {
                //TODO: switch to login screen
              },
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
          title: Text(Languages.of(context)!.successDialogTitle),
          actions: [
            TextButton(
              child: Text(Languages.of(context)!.registrationDialogCloseButtonText),
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
          title: Text(Languages.of(context)!.errorDialogTitle),
          content: Text(errorMessage),
          actions: [
            TextButton(
              child: Text(Languages.of(context)!.registrationDialogCloseButtonText),
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
