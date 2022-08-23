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

  // search page
  @override String get oftenSearched => "Commonly searched by others";
  @override String get recentlySearched => "Your recent searches";
  @override String get searchBarHint => "Search";

  // discovery page
  @override String get wasteBinOverviewTitle => "Waste Bin Overview";
  @override String get wasteBinOverviewSubtitle => "content, cycle, myths";
  @override String get tipsAndTricksTitle => "Tips and Tricks";
  @override String get tipsAndTricksSubtitle => "waste prevention, sorting, and more";
  @override String get collectionPointsTitle => "Collection Points";
  @override String get collectionPointsSubtitle => "recycling yard and more";

  // waste bin pages
  @override String get wasteBinContentLabel => "Content";
  @override String get wasteBinCycleLabel => "Cycle";
  @override String get wasteBinMythLabel => "Myths";
  @override String get wasteBinNoContentLabel => "Does not belong in there:";
  @override String get wasteBinYesContentLabel => "Does belong in there:";
  @override String get wasteBinMythCorrect => "Correct!";
  @override String get wasteBinMythIncorrect => "Not correct!";

  // collection point page
  @override String get filterLabelItemType => "Type of item:";
  @override String get detailButtonText => "Details";
  @override String get routeButtonText => "Plan route";
  @override String get cpDetailItemsAccepted => "Accepted Items:";
  @override String get cpDetailsOpeningHours => "Opening hours:";
}