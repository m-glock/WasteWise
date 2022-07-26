import 'package:recycling_app/logic/util/constants.dart';

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
  @override String get backButtonText => "Back";
  @override String get languageScreenTitle => "Choose language";
  @override String get languageScreenWelcomeText => "Welcome to ${Constants.appTitle}";
  @override String get languageScreenExplanation => "Please choose the language for the app. You can always change it later on in the settings.";
  @override String get purposeScreenTitle => "The purpose";
  @override String get purposeScreenQ1 => "Why is waste separated and what happens to it?";
  @override String get purposeScreenQ2 => "In which garbage bin does mirror glass actually belong?";
  @override String get purposeScreenExplanation => "${Constants.appTitle} is here to answer these questions for you! \n\nThe goal of the app is to educate about waste separation and recycling and to assist in the correct disposal of waste. Thus, items can be saved from the wrong trash can and recycled correctly.";
  @override String get learningModeScreenTitle => "Learning mode";
  @override String get learningModeScreenExplanation => "If you want to test your knowledge and get more information, you can turn on the learning mode. Questions, tips and challenges will help you learn more about the topic. The mode can be (de)activated at any time in the settings.";
  @override String get learningModeScreenLabel => "Activate learning mode";
  @override String get municipalityScreenTitle => "Choose municipality";
  @override String get municipalityScreenExplanation => "Your region will determine certain waste separation rules and available garbage bins. The pictograms below will appear in various places of the app to depict these waste bins.";
  @override String get municipalitySelectedTitle => "Region";
  @override String get municipalitySelectedNotFound => "Something went wrong. No garbage bins were found.";
  @override String get profileScreenTitle => "Create a profile";
  @override String get profileScreenExplanation => "A profile allows you to use the social forum of the app and to bookmark items and tips. The general information is still available without a profile and you can create an account at any time.";
  @override String get waitingForInitializationText => "Please be patient for a moment while the app is being set up.";

  // bottom navigation
  @override String get homePageName => "Home";
  @override String get searchPageName => "Search";
  @override String get discoveryPageName => "Discover";
  @override String get neighborhoodPageName => "Neighborhood";

  // dashboard
  @override String get tipTileTitle => "Tip of the Day";
  @override String get tipTileButtonText => "More Info";
  @override String get congratsTileTitle => "Well done!";
  @override String get congratsTileDefaultTitle => "Keep going";
  @override String get congratsTileDefaultText => "The more you learn, the easier it gets to find the correct garbage bin.";
  @override String get congratsTileFirstFragment => "You are in the top  ";
  @override String get congratsTileSecondFragment => "  in your neighborhood.";
  @override String get overviewTileTitle => "Total";
  @override String get overviewTileRecycledText => "  items searched";
  @override String get overviewTileSavedText => "  items saved";
  @override String get overviewTileShareText => "Share";
  @override String get overviewShareSuccessful => "Progress successfully shared with the neighborhood.";
  @override String get overviewShareUnsuccessful => "Sharing progress with the neighborhood failed.";
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
  @override String get logoutFailedText => "Something went wrong. Logout was not successful.";
  @override String get notAValidZipCode => " is not a valid zip code for your area.";
  @override String get missingUsernameOrData => "Make sure that all needed fields are filled out";

  // profile page
  @override String get profileLogoutButtonText => "Logout";

  // search history page
  @override String get searchHistoryPageTitle => "Search History";
  @override String get searchHistoryEmpty => "You have not searched for any items yet.";

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
  @override String get searchSortQuestion => "In which garbage bin would you put it?";
  @override String get alertDialogCorrectTitle => "Congratulation!";
  @override String get alertDialogCorrectExplanation => "By properly disposing of this item, you have ensured that it can be recycled correctly.";
  @override String get alertDialogWrongTitle => "Unfortunately wrong!";
  @override String get alertDialogWrongExplanation => "It's good that you checked with the app. This way you have ensured that the item can be disposed of and recycled correctly.";
  @override String get alertDialogPrompt => "This item belongs in the ";
  @override String get alertDialogButtonDismiss => "Understood";
  @override String get alertDialogButtonMoreInfo => "More Info";
  @override String get alertDialogNoItemTitle => "Item not found";
  @override String get alertDialogNoItemExplanation => "Unfortunately, there was no item associated with this barcode found.";
  @override String get alertDialogNoPackagingTitle => "No packaging info";
  @override String get alertDialogNoPackagingExplanation => "This either means that the item does not contain any packaging or that the information is not available in the logic. \nYou can check out the discovery section of the app to see if you can find more information about which bin this item might belong in.";
  @override String get barcodeAlertDialogButtonText => "Okay";
  @override String get aboutText => "About ";

  // item detail page
  @override String get itemDetailMaterialLabel => "Material: ";
  @override String get itemDetailWasteBinLabel => "Garbage bin: ";
  @override String get itemDetailSynonymsLabel => "Alternative terms: ";
  @override String get itemDetailMoreInfoLabel => "More Information about ";
  @override String get itemDetailExplanationLabel => "Explanation";
  @override String get itemDetailPreventionLabel => "Prevention";
  @override String get itemDetailTipsLabel => "Tips";
  @override String get itemDetailBarcodeWarningTitle => "Warning";
  @override String get itemDetailBarcodeWarningText => "This information comes from an open logic (http://www.opengtindb.org). No guarantee for the accuracy of the data.";

  // discovery page
  @override String get wasteBinOverviewTitle => "Garbage Cans";
  @override String get wasteBinOverviewSubtitle => "content, cycle, myths";
  @override String get tipsAndTricksTitle => "Tips and Tricks";
  @override String get tipsAndTricksSubtitle => "waste prevention, sorting, and more";
  @override String get collectionPointsTitle => "Collection Points";
  @override String get collectionPointsSubtitle => "recycling yards";

  // waste bin pages
  @override String get wasteBinContentLabel => "Content";
  @override String get wasteBinCycleLabel => "Cycle";
  @override String get wasteBinMythLabel => "Myths";
  @override String get wasteBinNoContentLabel => "Does not belong in there:";
  @override String get wasteBinYesContentLabel => "Does belong in there:";
  @override String get wasteBinShowMoreLabel => "more";
  @override String get wasteBinShowLessLabel => "less";
  @override String get wasteBinMythCorrect => "Correct!";
  @override String get wasteBinMythIncorrect => "Not correct!";

  // collection point page
  @override String get filterLabelItemType => "Type:";
  @override String get detailButtonText => "Details";
  @override String get routeButtonText => "Plan route";
  @override String get copDetailsAddressTitle => "Address:";
  @override String get cpDetailItemsAccepted => "Accepted Items:";
  @override String get cpDetailsOpeningHours => "Opening hours:";
  @override List<String> get weekdays => ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
  @override String get cpAlliesButtonShareText => "Search";
  @override String get cpAlliesButtonCancelText => "Cancel";
  @override String get cpAlliesButtonShareTitle => "Not enough items to make it worth the trip to the collection point?";
  @override String get cpAlliesButtonShareExplanation => "Find allies in your neighborhood and collect together.";
  @override String get cpAllySuccessfulText => "Successfully started looking for allies";
  @override String get cpAllyUnsuccessfulText => "Looking for allies failed. Please try again later";
  @override String get cpDropdownDefault => "All";
  @override String get cpOpeningHoursClosed => "closed";
  @override String get cpWithHazardousMaterial => "Accepts hazardous waste";
  @override String get cpWithSecondHand => "Accepts second hand goods";

  // tips page
  @override String get dropdownTipTypeLabel => "Tip type:";
  @override String get defaultTipTypeDropdownItem => "All types";
  @override String get dropdownWasteBinLabel => "Garbage bin type:";
  @override String get defaultCategoryDropdownItem => "All Garbage bins";
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
  @override String get filterByText => "Filter by:";

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
  @override String get contactPageValidationText => "Cannot be empty";
  @override String get contactPageEmailValidationText => "Not a valid email";

  // imprint
  @override String get imprintParagraphTitle => "Information according to § 5 TMG";
  @override String get legalNotes => "Legal notes";
  @override String get liabilityTitle => "Liability";
  @override String get liabilityText => "The information displayed in the app has been carefully selected and prepared according to the information provided by trenntstadt-berlin.de, bsr.de, and berlin-recycling.de. However, no responsibility is taken for the accuracy, completeness and timeliness.";
  @override String get iconsTitle => "Icons";

  // notifications
  @override String get notificationItemTitle => "Meet a challenge";
  @override String get notificationItemBody => "Check your knowledge and try to correctly sort a new item.";
  @override String get notificationTipTitle => "Did you know...";
  @override String get notificationTipBody => "Find out more about how you could improve your recycling behavior.";
  @override String get notificationSortTitle => "Do you remember...";
  @override String get notificationSortBody => "Check your knowledge about a recently wrongly sorted item.";
  @override String get notificationNotLoggedIn => "Please log in to get access to your search history.";
}