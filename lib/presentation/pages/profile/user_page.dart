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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Languages.of(context)!.profilePageName),
      ),
      body: FutureBuilder<bool>(
        future: isUserAuthenticated(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if(!snapshot.hasData){
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            bool _isAuthenticated = snapshot.data!;
            return _isAuthenticated ? const ProfileWidget() : const LoginWidget();
          }
        },
      )
    );
  }

  Future<bool> isUserAuthenticated() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getBool("authenticated") ?? false;
  }
}