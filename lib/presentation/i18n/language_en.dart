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
  @override String get languageScreenTitle => "Choose language";
  @override String get languageScreenExplanation => "Welcome to ${Constants.appTitle}. Please choose the language for the app. You can always change it later on in the settings.";
  @override String get purposeScreenTitle => "Purpose of the App";
  @override String get purposeScreenExplanation => "Every municipality in Germany has its own rules and might even differ in the type of waste bins they have available for sorting waste. Please let us know where you live so that we can adapt the app accordingly."; //TODO
  @override String get municipalityScreenTitle => "Choose municipality";
  @override String get municipalityScreenExplanation => "Your region will determine certain waste separation rules and available waste bins. The pictograms below will appear in certain places of the app to depict these waste bins.";
  @override String get municipalitySelectedTitle => "Region ";
  @override String get municipalitySelectedNotFound => "Something went wrong. No waste bins found.";
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
  @override String get congratsTileFirstFragment => "You are in the top  ";
  @override String get congratsTileSecondFragment => "  in your neighborhood.";
  @override String get overviewTileTitle => "Total";
  @override String get overviewTileRecycledText => "  items searched";
  @override String get overviewTileSavedText => "  items saved";
  @override String get progressTileTitle => "Progress";
  @override String get progressTileRecycledLabel => "Recycled";
  @override String get progressTileSavedLabel => "Saved";
  @override List<String> get months => ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];

  // registration/login page
  @override String get usernameHintText => "Username";
  @override String get passwordHintText => "Password";
  @override String get zipCodeHintText => "Zip code (optional)";
  @override String get emailHintText => "Email";
  @override String get signupButtonText => "Sign Up";
  @override String get loginButtonText => "Log in";
  @override String get goToLoginButtonText => "Already registered? Log in";
  @override String get goToSignupButtonText => "Not registered yet? Sign up";
  @override String get errorDialogTitle => "Something went wrong";
  @override String get registrationDialogCloseButtonText => "Okay";

  // profile page
  @override String get profileRecycledItemsText => "Amount of recycled items:";
  @override String get profileSavedItemsText => "Amount of saved items:";
  @override String get profileRankingText => "Ranking in neighborhood:";
  @override String get profileRankingPlaceText => "place";
  @override String get profileLogoutButtonText => "Logout";

  // search history page
  @override String get searchHistoryPageTitle => "Search History";

  // bookmark and bookmark page
  @override String get bookmarkPageTitle => "Bookmarks";
  @override String get bookmarkingFailedText => "Something went wrong. Bookmark was not successful.";
  @override String get noBookmarksAvailableText => "No bookmarks set.";
  @override String get itemBookmarkTagTitle => "Item";
  @override String get tipBookmarkTagTitle => "Tip";

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

  // item detail page
  @override String get itemDetailMaterialLabel => "Material: ";
  @override String get itemDetailWasteBinLabel => "Waste bin: ";
  @override String get itemDetailSynonymsLabel => "Alternative terms: ";
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
  @override String get cpAlliesButtonShareText => "Search";
  @override String get cpAlliesButtonCancelText => "Cancel";
  @override String get cpAlliesButtonShareTitle => "Join forces";
  @override String get cpAlliesButtonShareExplanation => "Not enough items to make it worth the trip to the collection point? Find allies through the forum in your neighborhood and collect together. Choose what kind of item you are trying to collect and a post will be created in the forum.";
  @override String get cpAllySuccessfulText => "Successfully started looking for allies";
  @override String get cpAllyUnsuccessfulText => "Looking for allies failed. Please try again later";
  @override String get cpDropdownDefault => "All";

  // tips page
  @override String get dropdownTipTypeLabel => "Tip type:";
  @override String get dropdownWasteBinLabel => "Waste bin type:";
  @override String get defaultDropdownItem => "All";
  @override String get emptyListText => "Nothing found";
  @override String get tipShareSuccessfulText => "Tip successfully shared";
  @override String get tipShareUnsuccessfulText => "Sharing tip failed. Please try again later";

  // neighborhood
  @override String get neighborhoodNotAuthenticatedText => "Only logged in users can access the neighborhood feed of the app. Please log in or register.";
  @override String get notLoggedInErrorText => "You need to be logged in for this action";
  @override String get cpPostSuccessfulText => "Post successfully created";
  @override String get cpPostUnsuccessfulText => "Post creation failed. Please try again later";
  @override String get threadReplyHintText => "Type a reply";
  @override String get askQuestionHintText => "Ask a question";
  @override String get threadPageTitle => "Thread";

  // settings page
  @override String get settingsPageTitle => "Settings";
  @override String get settingsPageLanguageSetting => "Language";
  @override String get settingsPageMunicipalitySetting => "Municipality";
  @override String get settingsPageLearnMoreSetting => "Learning mode";
  @override String get settingsPageAlertDialogTextStart => "The 'Learning Mode' feature includes";
  @override String get settingsPageAlertDialogBulletPoints => "\u2022  A sorting prompt for items"
      "\n\u2022  Regular challenges"
      "\n\u2022  Notification to test your knowledge";
  @override String get settingsPageAlertDialogTextEnd => "Its purpose is to help you learn more about recycling and waste separation. If you prefer quick answers and no unneccessary notifications, disable this feature.";

  // contact page
  @override String get contactPageIntroText => "You have a question or want to submit a suggestion? Please fill out the contact form. For technical concerns please use ";
  @override String get contactPageGitHub => "GitHub.";
  @override String get contactPageNameHintText => "Name";
  @override String get contactPageEmailHintText => "Email";
  @override String get contactPageContentHintText => "Content";
  @override String get contactPageSubmitButtonText => "Submit";
  @override String get contactPageImprintParagraphTitle => "Information according to § 5 TMG";
  @override String get contactPageValidationText => "Cannot be empty";
  @override String get contactPageEmailValidationText => "Not a valid email";
}