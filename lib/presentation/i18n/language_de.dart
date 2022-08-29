import 'languages.dart';

class LanguageDe extends Languages {

  // app bar
  @override String get notificationPageName => "Nachrichten";
  @override String get profilePageName => "Profil";

  // menu
  @override String get contactPageName => "Kontakt";
  @override String get imprintPageName => "Impressum";
  @override String get settingsPageName => "Einstellungen";

  // introduction
  @override String get doneButtonText => "Fertig";
  @override String get nextButtonText => "Weiter";
  @override String get skipButtonText => "Überspringen";
  @override String get languageScreenTitle => "Sprache auswählen";
  @override String get languageScreenExplanation => "Bitte wähle deine Sprache aus. Du kannst sie jederzeit in den Einstellungen ändern";
  @override String get municipalityExplanation => "Jede Gemeinde in Deutschland hat ihre eigenen Regeln und kann sich in manchen Fällen auch in der Auswahl der Mülltonnen von anderen unterscheiden. Bitte teile uns mit, in welcher Region du wohst damit die App entsprechend darauf angepasst werdem kann.";


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

  // search page
  @override String get oftenSearched => "Oft von anderen gesucht";
  @override String get recentlySearched => "Zuletzt von dir gesucht";
  @override String get searchBarHint => "Suche";
  @override String get searchBarItemNotExist => "Dieses Item ist unbekannt";
  @override String get barcodeButtonText => "Barcodescanner";
  @override String get searchSortQuestion => "In welchen Müll würden Sie es entsorgen?";
  @override String get alertDialogCorrectTitle => "Glückwunsch!";
  @override String get alertDialogCorrectExplanation => "Durch das richtige Entsorgen dieses Items hast du dafür gesorgt, dass es korrekt recycelt werden kann.";
  @override String get alertDialogWrongTitle => "Leider daneben!";
  @override String get alertDialogWrongExplanation => "Gut, dass du das in der App geprüpft hast. Somit hast du dafür gesortgt, dass der Gegenstand korrekt entsogt und recycelt werden kann.";
  @override String get alertDialogPrompt => "Dieses Item gehört in ";
  @override String get alertDialogButtonDismiss => "Verstanden";
  @override String get alertDialogButtonMoreInfo => "Mehr Info";

  // item detail page
  @override String get itemDetailMaterialLabel => "Material: ";
  @override String get itemDetailWasteBinLabel => "Tonne: ";
  @override String get itemDetailMoreInfoLabel => "Mehr Informationen über ";
  @override String get itemDetailExplanationLabel => "Erklärung";
  @override String get itemDetailPreventionLabel => "Vermeidung";
  @override String get itemDetailTipsLabel => "Tipps";

  // discovery page
  @override String get wasteBinOverviewTitle => "Mülleimer Übersicht";
  @override String get wasteBinOverviewSubtitle => "Inhalt, Kreislauf, Mythen";
  @override String get tipsAndTricksTitle => "Tipps und Tricks";
  @override String get tipsAndTricksSubtitle => "Müllvemreidung, Trennung, etc.";
  @override String get collectionPointsTitle => "Sammelstellen";
  @override String get collectionPointsSubtitle => "Recyclinghof, Altkleidercontainer, etc.";

  // waste bin pages
  @override String get wasteBinContentLabel => "Inhalt";
  @override String get wasteBinCycleLabel => "Kreislauf";
  @override String get wasteBinMythLabel => "Mythen";
  @override String get wasteBinNoContentLabel => "Das gehört rein:";
  @override String get wasteBinYesContentLabel => "Das gehört nicht rein:";
  @override String get wasteBinMythCorrect => "Stimmt!";
  @override String get wasteBinMythIncorrect => "Stimmt nicht!";

  // collection point page
  @override String get filterLabelItemType => "Art des Items:";
  @override String get detailButtonText => "Details";
  @override String get routeButtonText => "Route planen";
  @override String get cpDetailItemsAccepted => "Angenommene Items:";
  @override String get cpDetailsOpeningHours => "Geöffnet:";

  // tips page
  @override String get dropdownTipTypeLabel => "Art des Tipps:";
  @override String get dropdownWasteBinLabel => "Mülleimer:";
  @override String get defaultDropdownItem => "Alle";
  @override String get emptyListText => "Nichts gefunden";
}