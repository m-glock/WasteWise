import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:provider/provider.dart';
import 'package:recycling_app/logic/database_access/queries/general_queries.dart';
import 'package:recycling_app/logic/services/notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../logic/services/data_service.dart';
import '../../../../logic/util/user.dart';
import '../../../../model_classes/zip_code.dart';
import '../../../i18n/languages.dart';
import '../../../../logic/util/constants.dart';
import 'text_input_widget.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget(
      {Key? key, required this.authenticated, this.onlySignup = false})
      : super(key: key);

  final Function authenticated;
  final bool onlySignup;

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final TextEditingController controllerUsername = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  final TextEditingController controllerEmail = TextEditingController();
  final GlobalKey<AutoCompleteTextFieldState<ZipCode>> _key = GlobalKey();
  List<ZipCode> zipCodeSuggestions = [];
  ZipCode? _zipCode;
  String _zipCodeText = "";
  late bool _signup;

  @override
  void initState() {
    super.initState();
    _signup = widget.onlySignup;
    DataService dataService = Provider.of<DataService>(context, listen: false);
    if (dataService.zipCodesById.isEmpty) {
      _getZipCodes();
    } else {
      zipCodeSuggestions = dataService.zipCodesById.values.toList();
    }
  }

  void _getZipCodes() async {
    List<ZipCode> zipCodes = await GeneralQueries.getZipCodes(context);

    setState(() {
      zipCodeSuggestions = zipCodes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextInputWidget(
                  controller: controllerUsername,
                  hintText: Languages.of(context)!.usernameHintText,
                  inputType: TextInputType.text),
            ),
            if (_signup) ...[
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextInputWidget(
                    controller: controllerEmail,
                    hintText: Languages.of(context)!.emailHintText,
                    inputType: TextInputType.emailAddress),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: AutoCompleteTextField<ZipCode>(
                  clearOnSubmit: false,
                  suggestions: zipCodeSuggestions,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surface,
                    hintText: Languages.of(context)!.zipCodeHintText,
                    border: InputBorder.none,
                  ),
                  itemSorter: (ZipCode item1, ZipCode item2) {
                    return item1.zipCode.compareTo(item2.zipCode);
                  },
                  itemBuilder: (BuildContext context, ZipCode suggestion) {
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(suggestion.zipCode),
                    );
                  },
                  textSubmitted: (String data) {
                    ZipCode? selected = zipCodeSuggestions
                        .firstWhereOrNull((element) => element.zipCode == data);
                    if (selected != null) {
                      _zipCode = selected;
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            data + Languages.of(context)!.notAValidZipCode,
                        ),
                      ));
                    }
                  },
                  textChanged: (String text) {
                    _zipCodeText = text;
                  },
                  itemSubmitted: (ZipCode data) {
                    _zipCode = data;
                  },
                  key: _key,
                  itemFilter: (ZipCode suggestion, String query) {
                    return suggestion.zipCode.toLowerCase().startsWith(query.toLowerCase());
                  },
                ),
              ),
            ],
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextInputWidget(
                  isPassword: true,
                  hintText: Languages.of(context)!.passwordHintText,
                  controller: controllerPassword,
                  inputType: TextInputType.text),
            ),
            ElevatedButton(
              child: _signup
                  ? Text(Languages.of(context)!.signupButtonText)
                  : Text(Languages.of(context)!.loginButtonText),
              onPressed: () => _loginOrSignup(),
            ),
            TextButton(
              child: _signup
                  ? Text(Languages.of(context)!.goToLoginButtonText)
                  : Text(Languages.of(context)!.goToSignupButtonText),
              onPressed: () async {
                setState(() {
                  _signup = !_signup;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  void _loginOrSignup() async {
    final String username = controllerUsername.text.trim();
    final String password = controllerPassword.text.trim();

    if(username == "" || password == ""){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          Languages.of(context)!.missingUsernameOrData,
        ),
      ));
      return;
    }

    ParseResponse response;
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    if (_signup) {
      final String email = controllerEmail.text.trim();
      final ParseUser user = ParseUser.createUser(username, password, email);

      if(email == ""){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            Languages.of(context)!.missingUsernameOrData,
          ),
        ));
        return;
      }

      // set zip code
      if(_zipCode == null && _zipCodeText != ""){
        ZipCode? selected = zipCodeSuggestions
            .firstWhereOrNull((element) => element.zipCode == _zipCodeText);
        if (selected != null) {
          _zipCode = selected;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              _zipCodeText + Languages.of(context)!.notAValidZipCode,
            ),
          ));
          return;
        }
      }
      user.set("zip_code_id", _zipCode);
      if(_zipCode != null) {
        _prefs.setString(
            Constants.prefSelectedZipCode,
            _zipCode!.zipCode
        );
      }

      // set municipality
      String? municipalityId =
          _prefs.getString(Constants.prefSelectedMunicipalityCode);
      if (municipalityId != null) {
        ParseObject municipality = ParseObject("Municipality");
        municipality.set("objectId", municipalityId);
        user.set("municipality_id", municipality);
      }

      // sign up
      response = await Provider.of<User>(context, listen: false).signup(user);
    } else {
      // login
      final ParseUser user = ParseUser(username, password, null);
      response = await Provider.of<User>(context, listen: false).login(user);
    }

    if (response.success) {
      widget.authenticated();
      bool learnMore = _prefs.getBool(Constants.prefLearnMore) ?? false;
      if(learnMore){
        Provider.of<NotificationService>(context, listen: false)
            .startWronglySortedNotification();
      }
    } else {
      _showError(response.error!.message);
    }
  }

  void _showError(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Languages.of(context)!.errorDialogTitle),
          content: Text(errorMessage),
          actions: [
            TextButton(
              child: Text(
                  Languages.of(context)!.registrationDialogCloseButtonText),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
