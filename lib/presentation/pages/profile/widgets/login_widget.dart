import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../i18n/languages.dart';
import 'TextInputWidget.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

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
              child: Text('Log in'),
              onPressed: () {},
            ),
            TextButton(
              child: Text('Not registered yet? Sign up'),
              onPressed: () async {
                //TODO: switch to registration screen
              },
            ),
          ],
        ),
      ),
    );
  }
}

