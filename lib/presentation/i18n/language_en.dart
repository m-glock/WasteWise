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
  @override String get progressTileTitle => "Progress";

  // registration/login page
  @override String get usernameLabel => "Username";
  @override String get passwordLabel => "Password";
  @override String get emailLabel => "Email";
  @override String get signupButtonText => "Sign Up";
  @override String get loginButtonText => "Log in";
  @override String get goToLoginButtonText => "Already registered? Log in";
  @override String get goToSignupButtonText => "Not registered yet? Sign up";
  @override String get errorDialogTitle => "Something went wrong";
  @override String get registrationDialogCloseButtonText => "Okay";

}