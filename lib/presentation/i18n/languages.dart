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

  // introduction
  String get nextButtonText;
  String get doneButtonText;
  String get languageScreenTitle;
  String get languageScreenExplanation;
  String get purposeScreenTitle;
  String get purposeScreenExplanation;
  String get municipalityScreenTitle;
  String get municipalityScreenExplanation;
  String get municipalitySelectedTitle;
  String get municipalitySelectedNotFound;
  String get profileScreenTitle;
  String get profileScreenExplanation;

  // bottom navigation
  String get homePageName;
  String get searchPageName;
  String get discoveryPageName;
  String get neighborhoodPageName;

  // dashboard page
  String get tipTileTitle;
  String get tipTileButtonText;
  String get congratsTileTitle;
  String get congratsTileFirstFragment;
  String get congratsTileSecondFragment;
  String get overviewTileTitle;
  String get overviewTileRecycledText;
  String get overviewTileSavedText;
  String get progressTileTitle;
  String get progressTileRecycledLabel;
  String get progressTileSavedLabel;
  List<String> get months;

  // registration/login page
  String get usernameLabel;
  String get emailLabel;
  String get passwordLabel;
  String get zipCodeLabel;
  String get signupButtonText;
  String get loginButtonText;
  String get goToLoginButtonText;
  String get goToSignupButtonText;
  String get errorDialogTitle;
  String get registrationDialogCloseButtonText;

  // profile page
  String get profileRecycledItemsText;
  String get profileSavedItemsText;
  String get profileRankingText;
  String get profileRankingPlaceText;
  String get profileLogoutButtonText;

  // search history page
  String get searchHistoryPageTitle;

  // bookmark and bookmark page
  String get bookmarkPageTitle;
  String get bookmarkingFailedText;
  String get noBookmarksAvailableText;
  String get itemBookmarkTagTitle;
  String get tipBookmarkTagTitle;

  // search page
  String get searchBarHint;
  String get recentlySearched;
  String get oftenSearched;
  String get searchBarItemNotExist;
  String get barcodeButtonText;
  String get searchSortQuestion;
  String get alertDialogCorrectTitle;
  String get alertDialogCorrectExplanation;
  String get alertDialogWrongTitle;
  String get alertDialogWrongExplanation;
  String get alertDialogPrompt;
  String get alertDialogButtonDismiss;
  String get alertDialogButtonMoreInfo;

  // item detail page
  String get itemDetailMaterialLabel;
  String get itemDetailWasteBinLabel;
  String get itemDetailSynonymsLabel;
  String get itemDetailMoreInfoLabel;
  String get itemDetailExplanationLabel;
  String get itemDetailTipsLabel;
  String get itemDetailPreventionLabel;

  // discovery page
  String get wasteBinOverviewTitle;
  String get wasteBinOverviewSubtitle;
  String get tipsAndTricksTitle;
  String get tipsAndTricksSubtitle;
  String get collectionPointsTitle;
  String get collectionPointsSubtitle;

  // waste bin pages
  String get wasteBinContentLabel;
  String get wasteBinCycleLabel;
  String get wasteBinMythLabel;
  String get wasteBinYesContentLabel;
  String get wasteBinNoContentLabel;
  String get wasteBinMythCorrect;
  String get wasteBinMythIncorrect;

  // collection point page
  String get filterLabelItemType;
  String get detailButtonText;
  String get routeButtonText;
  String get cpDetailItemsAccepted;
  String get cpDetailsOpeningHours;

  // tips page
  String get dropdownTipTypeLabel;
  String get dropdownWasteBinLabel;
  String get defaultDropdownItem;
  String get emptyListText;

  // neighborhood
  String get neighborhoodNotAuthenticatedText;

  // settings page
  String get settingsPageTitle;
  String get settingsPageLanguageSetting;
  String get settingsPageMunicipalitySetting;

  // contact page
  String get contactPageIntroText;
  String get contactPageGitHub;
  String get contactPageNameHintText;
  String get contactPageEmailHintText;
  String get contactPageContentHintText;
  String get contactPageSubmitButtonText;
  String get contactPageImprintParagraphTitle;
  String get contactPageValidationText;
  String get contactPageEmailValidationText;
}