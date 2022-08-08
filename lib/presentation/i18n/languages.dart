import 'package:flutter/material.dart';

abstract class Languages {

  static Languages? of(BuildContext context) {
    return Localizations.of<Languages>(context, Languages);
  }

  // app bar
  String get notificationPageName;
  String get profilePageName;

  // menu
  String get imprintPageName;
  String get contactPageName;
  String get settingsPageName;

  // bottom navigation
  String get homePageName;
  String get searchPageName;
  String get discoveryPageName;
  String get neighborhoodPageName;

  // dashboard page
  String get tipTileTitle;
  String get tipTileButtonText;
  String get congratsTileTitle;
  String get overviewTileTitle;
  String get overviewTileRecycledText;
  String get overviewTileSavedText;
  String get progressTileTitle;

  // registration/login page
  String get usernameLabel;
  String get emailLabel;
  String get passwordLabel;
  String get signupButtonText;
  String get goToLoginButtonText;
  String get successDialogTitle;
  String get errorDialogTitle;
  String get registrationDialogCloseButtonText;
}