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
}