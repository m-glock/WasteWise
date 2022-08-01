import 'languages.dart';

class LanguageEn extends Languages {

  // app bar
  @override String get notificationPageName => "Notifications";
  @override String get profilePageName => "Profile";

  // menu
  @override String get contactPageName => "Contact";
  @override String get imprintPageName => "Imprint";
  @override String get settingsPageName => "Settings";

  // bottom navigation
  @override String get homePageName => "Home";
  @override String get searchPageName => "Search";
  @override String get discoveryPageName => "Discover";
  @override String get neighborhoodPageName => "Neighborhood";

}