import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../i18n/languages.dart';
import 'text_input_widget.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key, required this.authenticated}) : super(key: key);

  final Function authenticated;

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final TextEditingController controllerUsername = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();

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
                  isPassword: true,
                  controller: controllerPassword,
                  label: Languages.of(context)!.passwordLabel,
                  inputType: TextInputType.text),
            ),
            ElevatedButton(
              child: Text(Languages.of(context)!.loginButtonText),
              onPressed: () => doUserLogin(),
            ),
            TextButton(
              child: Text(Languages.of(context)!.goToSignupButtonText),
              onPressed: () async {
                //TODO: switch to registration screen
              },
            ),
          ],
        ),
      ),
    );
  }

  void doUserLogin() async {
    final String username = controllerUsername.text.trim();
    final String password = controllerPassword.text.trim();

    final ParseUser user = ParseUser(username, password, null);

    var response = await user.login();

    if (response.success) {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      _prefs.setBool("authenticated", true);
      widget.authenticated();
    } else {
      _showError(response.error!.message);
    }
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
              child: Text(
                  Languages.of(context)!.registrationDialogCloseButtonText),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
