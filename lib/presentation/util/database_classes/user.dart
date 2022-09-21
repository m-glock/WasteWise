import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class User extends ChangeNotifier {

  ParseUser? currentUser;

  User({this.currentUser});

  Future<ParseResponse> login(ParseUser user) async {
    ParseResponse response = await user.login();
    currentUser = await ParseUser.currentUser();
    notifyListeners();
    return response;
  }

  Future<ParseResponse> signup(ParseUser user) async {
    ParseResponse response = await user.signUp();
    currentUser = await ParseUser.currentUser();
    notifyListeners();
    return response;
  }

  Future<ParseResponse?> logout() async {
    ParseResponse? response = await currentUser?.logout();
    currentUser = null;
    notifyListeners();
    return response;
  }
}