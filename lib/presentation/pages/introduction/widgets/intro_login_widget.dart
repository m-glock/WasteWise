import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:recycling_app/presentation/pages/profile/widgets/login_widget.dart';
import 'package:recycling_app/presentation/pages/profile/widgets/profile_widget.dart';

class IntroLoginWidget extends StatefulWidget {
  const IntroLoginWidget({Key? key}): super(key: key);

  @override
  State<IntroLoginWidget> createState() =>
      _IntroLoginWidgetState();
}

class _IntroLoginWidgetState extends State<IntroLoginWidget> {

  bool _isAuthenticated = false;

  void _checkIfAuthenticated() async {
    ParseUser? currentUser = await ParseUser.currentUser();
    setState(() {
      _isAuthenticated = currentUser != null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isAuthenticated
        ? ProfileWidget(authenticated: _checkIfAuthenticated, introView: true,)
        : LoginWidget(authenticated: _checkIfAuthenticated);
  }
}
