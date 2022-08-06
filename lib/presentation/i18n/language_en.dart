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

  // dashboard
  @override String get tipTileTitle => "Tip of the Day";
  @override String get tipTileButtonText => "More Info";
  @override String get congratsTileTitle => "Congratulation!";
  @override String get overviewTileTitle => "Total";
  @override String get overviewTileRecycledText => "You have reecyceled 123 items.";
  @override String get overviewTileSavedText => "You have saved 69 items from the wrong waste bin.";

}