import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

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
  final TextEditingController controllerEmail = TextEditingController();

  bool _signup = false;

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
            if(_signup)
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
              child: _signup
                  ? Text(Languages.of(context)!.signupButtonText)
                  : Text(Languages.of(context)!.loginButtonText),
              onPressed: () => _loginOrSignup(),
            ),
            TextButton(
              child: _signup
                  ? Text(Languages.of(context)!.goToLoginButtonText)
                  : Text(Languages.of(context)!.goToSignupButtonText),
              onPressed: () async {
                setState(() {
                  _signup = !_signup;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  void _loginOrSignup() async {
    final String username = controllerUsername.text.trim();
    final String password = controllerPassword.text.trim();

    ParseResponse response;
    if(_signup){
      final String email = controllerEmail.text.trim();
      final ParseUser user = ParseUser.createUser(username, password, email);
      response = await user.signUp();
    } else {
      final ParseUser user = ParseUser(username, password, null);
      response = await user.login();
      _setACLsOnServer();
    }

    if (response.success) {
      widget.authenticated();
    } else {
      _showError(response.error!.message);
    }
  }

  void _setACLsOnServer() async {
    final ParseCloudFunction function = ParseCloudFunction('setUsersAcls');
    final ParseResponse parseResponse = await function.execute();
    if (parseResponse.success && parseResponse.result != null) {
      debugPrint(parseResponse.result);
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
