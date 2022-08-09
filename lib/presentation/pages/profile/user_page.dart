import 'package:flutter/material.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';
import 'package:recycling_app/presentation/pages/profile/profile_widget.dart';
import 'package:recycling_app/presentation/pages/profile/widgets/login_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      body: Column(
        children: [
          _isAuthenticated ? const ProfileWidget() : LoginWidget(authenticated: _checkIfAuthenticated)
        ],
      ),
    );
  }

  void _checkIfAuthenticated() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      _isAuthenticated = _prefs.getBool("authenticated") ?? false;
    });
  }
}