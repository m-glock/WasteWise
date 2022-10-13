import '../../logic/util/constants.dart';
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
  @override String get backButtonText => "Zurück";
  @override String get languageScreenTitle => "Sprache auswählen";
  @override String get languageScreenWelcomeText => "Willkommen bei ${Constants.appTitle}";
  @override String get languageScreenExplanation => "Bitte wähle deine Sprache aus. Du kannst sie später jederzeit in deinen Einstellungen ändern";
  @override String get purposeScreenTitle => "Das Ziel";
  @override String get purposeScreenQ1 => "Warum wird Müll getrennt und was passiert dann damit?";
  @override String get purposeScreenQ2 => "Und in welche Mülltonne gehört eigentlich Spiegelglas?";
  @override String get purposeScreenExplanation => "${Constants.appTitle} ist dafür da, um dir diese Fragen zu beantworten! \n\nDas Ziel der App ist es, über Mülltrennung und Recycling aufzuklären und bei der korrekten Entsorgung des Mülls zu unterstützen. Somit können Gegenstände vor dem falschen Mülleimer gerettet und korrekt recycelt werden.";
  @override String get learningModeScreenTitle => "Lernmodus";
  @override String get learningModeScreenExplanation => "Wenn du dein Wissen prüfen und mehr Informationen erhalten möchtest, kannst du den Lernmodus einschalten. Fragen, Tipps und Herausforderung helfen dir dann dabei, mehr über das Thema zu lernen. Der Modus kann jederzeit in den Einstellungen (de)aktiviert werden.";
  @override String get learningModeScreenLabel => "Lernmodus aktivieren";
  @override String get municipalityScreenTitle => "Region auswählen";
  @override String get municipalityScreenExplanation => "Deine Region bestimmt spezielle Regeln bei der Mülltrennung und die vorhanden Mülleimer. Die unten dargestellten Piktogramme werden an verschiedenen Stellen in der App genutzt, um die entsprechenden Mülleimer zu symbolisieren.";
  @override String get municipalitySelectedTitle => "Region";
  @override String get municipalitySelectedNotFound => "Etwas ist schiefgelaufen. Es wurden keine passenden Mülleimer gefunden.";
  @override String get profileScreenTitle => "Profil erstellen";
  @override String get profileScreenExplanation => "Ein Profil ermöglicht es dir das soziale Forum der App zu nutzen und Items und Tipps zu favorisieren. Die allgemeinen Informationen sind auch ohne Registrierung zugänglich und du kannst dich jederzeit nachträglich noch registrieren.";
  @override String get waitingForInitializationText => "Habe bitte einen Moment Gedult, während die App eingerichtete wird.";

  // bottom navigation
  @override String get homePageName => "Home";
  @override String get searchPageName => "Suche";
  @override String get discoveryPageName => "Entdecken";
  @override String get neighborhoodPageName => "Nachbarschaft";

  // dashboard
  @override String get tipTileTitle => "Tipp des Tages";
  @override String get tipTileButtonText => "Mehr erfahren";
  @override String get congratsTileTitle => "Glückwunsch!";
  @override String get congratsTileDefaultTitle => "Weiter so";
  @override String get congratsTileDefaultText => "Je mehr du lernst, desto einfacher ist es die richtige Tonne zu finden.";
  @override String get congratsTileFirstFragment => "Du bist in den Top  ";
  @override String get congratsTileSecondFragment => "  in deiner Nachbarschaft";
  @override String get overviewTileTitle => "Insgesamt";
  @override String get overviewTileRecycledText => " Items recycelt";
  @override String get overviewTileSavedText => " Items gerettet";
  @override String get overviewTileShareText => "Teilen";
  @override String get overviewShareSuccessful => "Fortschritt erfolgreich mit der Nachbarschaft geteilt.";
  @override String get overviewShareUnsuccessful => "Fortschritt mit der Nachbarschaft teilen ist fehlgeschlagen.";
  @override String get progressTileTitle => "Fortschritt";
  @override String get progressTileRecycledLabel => "Recycelt";
  @override String get progressTileSavedLabel => "Gerettet";
  @override List<String> get months => ["Jan", "Feb", "Mär", "Apr", "Mai", "Jun", "Jul", "Aug", "Sep", "Okt", "Nov", "Dez"];

  // registration/login page
  @override String get usernameHintText => "Username";
  @override String get passwordHintText => "Passwort";
  @override String get emailHintText => "E-Mail";
  @override String get zipCodeHintText => "Postleitzahl (optional)";
  @override String get signupButtonText => "Registrieren";
  @override String get loginButtonText => "Einloggen";
  @override String get goToLoginButtonText => "Bereits registriert? Zum Login";
  @override String get goToSignupButtonText => "Noch kein Konto? Zur Registrierung";
  @override String get errorDialogTitle => "Etwas ist schief gelaufen";
  @override String get registrationDialogCloseButtonText => "Okay";
  @override String get logoutFailedText => "Etwas ist schief gelaufen. Logout konnte nicht durchgeführt werden.";
  @override String get notAValidZipCode => " ist keine valide Postleitzahl für die ausgewählte Region.";

  // profile page
  @override String get profileLogoutButtonText => "Logout";

  // search history page
  @override String get searchHistoryPageTitle => "Suchverlauf";

  // bookmark and bookmark page
  @override String get bookmarkPageTitle => "Lesezeichen";
  @override String get bookmarkingFailedText => "Etwas ist schiefgelaufen. Lesezeichen konnte nicht gesetzt werden.";
  @override String get noBookmarksAvailableText => "Keine Lesezeichen gesetzt.";
  @override String get itemBookmarkTagTitle => "Item";
  @override String get tipBookmarkTagTitle => "Tipp";

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
  @override String get alertDialogWrongExplanation => "Gut, dass du das in der App geprüft hast. Somit hast du dafür gesortgt, dass der Gegenstand korrekt entsogt und recycelt werden kann.";
  @override String get alertDialogPrompt => "Dieses Item gehört in ";
  @override String get alertDialogButtonDismiss => "Verstanden";
  @override String get alertDialogButtonMoreInfo => "Mehr Info";
  @override String get alertDialogNoItemTitle => "Item nicht gefunden";
  @override String get alertDialogNoItemExplanation => "Leider wurde für den Barcode kein entsprechendes Item gefunden.";
  @override String get alertDialogNoPackagingTitle => "Keine Verpackungsinformationen";
  @override String get alertDialogNoPackagingExplanation => "Entweder besitzt das gesuchte Item keine Verpackung, oder es sind keine entsprechenden Daten in der Datenbank hinterlegt. \nDu kannst den Bereich 'Entdecken' prüfen und sehen, ob du dort Informationen findest, um den passenden Mülleimer zu bestimmen.";
  @override String get barcodeAlertDialogButtonText => "Okay";
  @override String get aboutText => "Zum Thema ";

  // item detail page
  @override String get itemDetailMaterialLabel => "Material: ";
  @override String get itemDetailWasteBinLabel => "Mülltonne: ";
  @override String get itemDetailSynonymsLabel => "Alternative Begriffe: ";
  @override String get itemDetailMoreInfoLabel => "Mehr Informationen über ";
  @override String get itemDetailExplanationLabel => "Erklärung";
  @override String get itemDetailPreventionLabel => "Vermeidung";
  @override String get itemDetailTipsLabel => "Tipps";
  @override String get itemDetailBarcodeWarningTitle => "Achtung";
  @override String get itemDetailBarcodeWarningText => "Diese Informationen sind von einer offenen Datenbank übernommen (http://www.opengtindb.org). Keine Garantie für die Richtigkeit der Daten.";

  // discovery page
  @override String get wasteBinOverviewTitle => "Mülltonnen";
  @override String get wasteBinOverviewSubtitle => "Inhalt, Kreislauf, Mythen";
  @override String get tipsAndTricksTitle => "Tipps und Tricks";
  @override String get tipsAndTricksSubtitle => "Müllvemreidung, Trennung, etc.";
  @override String get collectionPointsTitle => "Sammelstellen";
  @override String get collectionPointsSubtitle => "Recyclinghöfe";

  // waste bin pages
  @override String get wasteBinContentLabel => "Inhalt";
  @override String get wasteBinCycleLabel => "Kreislauf";
  @override String get wasteBinMythLabel => "Mythen";
  @override String get wasteBinNoContentLabel => "Das gehört rein:";
  @override String get wasteBinYesContentLabel => "Das gehört nicht rein:";
  @override String get wasteBinShowMoreLabel => "mehr";
  @override String get wasteBinShowLessLabel => "weniger";
  @override String get wasteBinMythCorrect => "Stimmt!";
  @override String get wasteBinMythIncorrect => "Stimmt nicht!";

  // collection point page
  @override String get filterLabelItemType => "Art:";
  @override String get detailButtonText => "Details";
  @override String get routeButtonText => "Route planen";
  @override String get copDetailsAddressTitle => "Address:";
  @override String get cpDetailItemsAccepted => "Angenommene Items:";
  @override String get cpDetailsOpeningHours => "Geöffnet:";
  @override List<String> get weekdays => ["Montag", "Dienstag", "Mittwoch", "Donnerstag", "Freitag", "Samstag", "Sonntag"];
  @override String get cpAlliesButtonShareText => "Suchen";
  @override String get cpAlliesButtonCancelText => "Abbrechen";
  @override String get cpAlliesButtonShareTitle => "Nicht genügend Items, damit sich der Weg zur Annahmestelle lohnt?";
  @override String get cpAlliesButtonShareExplanation => "Suche Mitstreiter in deiner Nachbarschaft und sammelt gemeinsam.";
  @override String get cpAllySuccessfulText => "Suche nach Mitstreitern erfolgreich gestartet";
  @override String get cpAllyUnsuccessfulText => "Suche nach Mitstreitern fehlgeschlagen. Bitte später erneut versuchen";
  @override String get cpDropdownDefault => "Alle";
  @override String get cpOpeningHoursClosed => "geschlossen";
  @override String get cpWithHazardousMaterial => "mit Schadstoffannahmestelle";
  @override String get cpWithSecondHand => "Nimmt gebrauchte Waren an";

  // tips page
  @override String get dropdownTipTypeLabel => "Art des Tipps:";
  @override String get defaultTipTypeDropdownItem => "Alle Arten";
  @override String get dropdownWasteBinLabel => "Mülleimer:";
  @override String get defaultCategoryDropdownItem => "Alle Mülleimer";
  @override String get emptyListText => "Nichts gefunden";
  @override String get tipShareSuccessfulText => "Tipp erfolgreich geteilt";
  @override String get tipShareUnsuccessfulText => "Teilen des Tipps fehlgeschagen. Bitte später erneut versuchen";

  // neighborhood
  @override String get neighborhoodNotAuthenticatedText => "Nur eigeloggte Nutzer können den Nachbarschaftsfeed benutzen. Bitte melde dich an oder registriere dich.";
  @override String get notLoggedInErrorText => "Sie müssen für diese Aktion angemeldet sein";
  @override String get cpPostSuccessfulText => "Post erfolgreich erstellt";
  @override String get cpPostUnsuccessfulText => "Erstellen des Posts fehlgeschlagen. Bitte später erneut versuchen";
  @override String get threadReplyHintText => "Schreibe eine Antwort";
  @override String get askQuestionHintText => "Stelle eine Frage";
  @override String get threadPageTitle => "Diskussion";
  @override String get filterByText => "Filtern nach:";

  // settings page
  @override String get settingsPageTitle => "Einstellungen";
  @override String get settingsPageLanguageSetting => "Sprache";
  @override String get settingsPageMunicipalitySetting => "Region";
  @override String get settingsPageLearnMoreSetting => "Lernmodus";
  @override String get settingsPageAlertDialogTextStart => "Die $settingsPageLearnMoreSetting Funktion beinhaltet";
  @override String get settingsPageAlertDialogBulletPoints => "\u2022  Eine Sortieraufforderung für Items"
      "\n\u2022  Regelmäßige Herausforderungen"
      "\n\u2022  Benachrichtigungen zur Wissensprüfung";
  @override String get settingsPageAlertDialogTextEnd => "Das Ziel ist es, Ihnen zu helfen, mehr über Recycling und Abfalltrennung zu lernen. Wenn Sie schnelle Antworten und keine unnötigen Benachrichtigungen bevorzugen, deaktivieren Sie diese Funktion.";


  // contact page
  @override String get contactPageIntroText => "Sie haben Fragen oder möchten Vorschläge einbringen? Füllen Sie das Kontaktformular aus. Für technische Anliegen nutzen Sie bitte ";
  @override String get contactPageGitHub => "GitHub.";
  @override String get contactPageNameHintText => "Name";
  @override String get contactPageEmailHintText => "E-Mail";
  @override String get contactPageContentHintText => "Inhalt";
  @override String get contactPageSubmitButtonText => "Abschicken";
  @override String get contactPageValidationText => "Darf nicht leer sein.";
  @override String get contactPageEmailValidationText => "Keine valide E-Mail Adresse";

  // imprint
  @override String get imprintParagraphTitle => "Angaben gemäß § 5 TMG";
  @override String get legalNotes => "Rechtliche Hinweise";
  @override String get liabilityTitle => "Haftung";
  @override String get liabilityText => "Die in der App angezeigten Informationen sind sorgfältig ausgewählt und wurden entsprechend der Informationen von trenntstadt-berlin.de, bsr.de, und berlin-recycling.de aufbereitet. Jedoch wird keine Gewähr für die Richtigkeit, Vollständigkeit und Aktualität übernommen.";
  @override String get iconsTitle => "Icons";

  // notifications
  @override String get notificationItemTitle => "Stelle dich einer Herausforderung";
  @override String get notificationItemBody => "Prüfe dein Wissen und versuche den richtigen Mülleimer für ein neues Item zu finden.";
  @override String get notificationTipTitle => "Wusstest du schon...";
  @override String get notificationTipBody => "Lerne mehr darüber, wie du dein Recyclingverhalten verbessern kannst.";
  @override String get notificationSortTitle => "Erinnerst du dich...";
  @override String get notificationSortBody => "Prüfe dein Wissen über ein kürzlich falsch einsortiertes Item.";
  @override String get notificationNotLoggedIn => "Bitte logge dich ein, um Zugriff auf deinen Suchverlauf zu bekommen.";
}