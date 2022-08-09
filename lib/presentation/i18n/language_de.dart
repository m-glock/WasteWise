import 'languages.dart';

class LanguageDe extends Languages {

  // app bar
  @override String get notificationPageName => "Nachrichten";
  @override String get profilePageName => "Profil";

  // menu
  @override String get contactPageName => "Kontakt";
  @override String get imprintPageName => "Impressum";
  @override String get settingsPageName => "Einstellungen";

  // bottom navigation
  @override String get homePageName => "Home";
  @override String get searchPageName => "Suche";
  @override String get discoveryPageName => "Entdecken";
  @override String get neighborhoodPageName => "Nachbarschaft";

  // dashboard
  @override String get tipTileTitle => "Tipp des Tages";
  @override String get tipTileButtonText => "Mehr erfahren";
  @override String get congratsTileTitle => "Glückwunsch!";
  @override String get overviewTileTitle => "Insgesamt";
  @override String get overviewTileRecycledText => "Du hast 123 items recycelt.";
  @override String get overviewTileSavedText => "Du hast 69 items vor dem falschen Mülleimer gerettet.";
  @override String get progressTileTitle => "Fortschritt";

  // registration/login page
  @override String get usernameLabel => "Username";
  @override String get passwordLabel => "Passwort";
  @override String get emailLabel => "E-Mail";
  @override String get signupButtonText => "Registrieren";
  @override String get loginButtonText => "Einloggen";
  @override String get goToLoginButtonText => "Bereits registriert? Zum Login";
  @override String get goToSignupButtonText => "Noch kein Konto? Zur Registrierung";
  @override String get errorDialogTitle => "Etwas ist schief gelaufen";
  @override String get registrationDialogCloseButtonText => "Okay";
}