import 'package:recycling_app/presentation/util/constants.dart';

import 'languages.dart';

class LanguageEn extends Languages {

  // app bar
  @override String get notificationPageName => "Notifications";
  @override String get profilePageName => "Profile";

  // menu
  @override String get contactPageName => "Contact";
  @override String get imprintPageName => "Imprint";
  @override String get settingsPageName => "Settings";

  // introduction
  @override String get doneButtonText => "Done";
  @override String get nextButtonText => "Next";
  @override String get skipButtonText => "Skip";
  @override String get languageScreenTitle => "Choose language";
  @override String get languageScreenExplanation => "Welcome to ${Constants.appTitle}. Please choose the language for the app. You can always change it later on in the settings.";
  @override String get purposeScreenTitle => "Purpose of the App";
  @override String get purposeScreenExplanation => ""; //TODO
  @override String get municipalityScreenTitle => "Choose municipality";
  @override String get municipalityScreenExplanation => "Every municipality in Germany has its own rules and might even differ in the type of waste bins they have available for sorting waste. Please let us know where you live so that we can adapt the app accordingly.";
  @override String get profileScreenTitle => "Create a profile";
  @override String get profileScreenExplanation => "A profile allows you to use the social forum of the app and to bookmark certain items or tips. The general information is still available without a profile and you can still create an account at a later date.";

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
  @override String get searchBarItemNotExist => "This item is unknown";
  @override String get barcodeButtonText => "Barcode Scanner";
  @override String get searchSortQuestion => "In which waste bin would you put it?";
  @override String get alertDialogCorrectTitle => "Congratulation!";
  @override String get alertDialogCorrectExplanation => "By properly disposing of this item, you have ensured that it can be recycled correctly.";
  @override String get alertDialogWrongTitle => "Unfortunately wrong!";
  @override String get alertDialogWrongExplanation => "It's good that you checked with the app. This way you have ensured that the item can be disposed of and recycled correctly.";
  @override String get alertDialogPrompt => "This item belongs in the ";
  @override String get alertDialogButtonDismiss => "Understood";
  @override String get alertDialogButtonMoreInfo => "More Info";
  @override String get barcodeAlertDialogTitle => "Item not found";
  @override String get barcodeAlertDialogExplanation => "Unfortunately, there was no item associated with this barcode found.";
  @override String get barcodeAlertDialogButtonText => "Okay";

  // item detail page
  @override String get itemDetailMaterialLabel => "Material: ";
  @override String get itemDetailWasteBinLabel => "Waste bin: ";
  @override String get itemDetailMoreInfoLabel => "More Information about ";
  @override String get itemDetailExplanationLabel => "Explanation";
  @override String get itemDetailPreventionLabel => "Prevention";
  @override String get itemDetailTipsLabel => "Tips";

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

  // tips page
  @override String get dropdownTipTypeLabel => "Tip type:";
  @override String get dropdownWasteBinLabel => "Waste bin type:";
  @override String get defaultDropdownItem => "All";
  @override String get emptyListText => "Nothing found";

  // neighborhood
  @override String get neighborhoodNotAuthenticatedText => "Only logged in users can access the neighborhood feed of the app. Please log in or register.";
}