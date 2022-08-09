import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../i18n/languages.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({Key? key, required this.authenticated}) : super(key: key);

  final Function authenticated;

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text('Profile Page'),
          ElevatedButton(
              onPressed: () => logout(),
              child: const Text('Log out'),
          )
        ],
      ),
    );
  }

  void logout() async {
    final user = await ParseUser.currentUser() as ParseUser;
    var response = await user.logout();

    if (response.success) {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      _prefs.setBool("authenticated", false);
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