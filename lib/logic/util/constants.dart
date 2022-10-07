import 'package:flutter/material.dart';

class Constants{

  // App title
  static const String appTitle = "WasteWise";

  // intro screen
  static Map<Locale, String> languages = {
    const Locale("de", ""): "Deutsch",
    const Locale("en", ""): "English"
  };

  //SharedPrefs
  static String prefSelectedMunicipalityCode = "SelectedMunicipality";
  static String prefSelectedZipCode = "SelectedZipCode";
  static String prefIntroDone = "IntroDone";
  static String prefLearnMore = "LearnMore";

  // GraphQL setup
  static String apiURL= "https://parseapi.back4app.com/graphql";
  static const String kParseApplicationId = "tqa1Cgvy94m9L6i7tFTMPXMVYANwy4qELWhzf5Nh";
  static const String kParseClientKey = "YveWcquaobxddd2VALkC37Oej5MXCNO9kUcKevuW";

  // scheduled notification
  static String channelId = "ScheduledRecyclingAppNotification";
  static String channelName = "RecyclingAppNotification";
  static String channelDescription = "channel used for recycling app notification about tips and items.";

  // UI elements
  static double pagePadding = 15;
  static BorderRadius tileBorderRadius = const BorderRadius.all(Radius.circular(20));

}