import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';
import 'package:recycling_app/presentation/pages/profile/widgets/profile_widget.dart';
import 'package:recycling_app/presentation/pages/profile/widgets/login_widget.dart';

import '../../util/constants.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  bool _isAuthenticated = false;

  @override
  void initState() {
    super.initState();
    _checkIfAuthenticated();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Languages.of(context)!.profilePageName),
      ),
      body: Padding(
        padding: EdgeInsets.all(Constants.pagePadding),
        child: _isAuthenticated
            ? ProfileWidget(authenticated: _checkIfAuthenticated)
            : LoginWidget(authenticated: _checkIfAuthenticated),
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  void _checkIfAuthenticated() async {
    ParseUser? currentUser = await ParseUser.currentUser();
    setState(() {
      _isAuthenticated = currentUser != null;
    });
  }
}