import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:recycling_app/presentation/pages/profile/bookmark_page.dart';
import 'package:recycling_app/presentation/pages/profile/search_history_page.dart';

import '../../../i18n/languages.dart';
import '../../../util/constants.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({Key? key, required this.authenticated})
      : super(key: key);

  final Function authenticated;

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  ParseUser? current;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  void _getCurrentUser() async {
    current = await ParseUser.currentUser() as ParseUser;
  }

  void _logout() async {
    ParseResponse response = await current!.logout();

    if (response.success) {
      widget.authenticated();
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
                Languages.of(context)!.registrationDialogCloseButtonText,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius:
                BorderRadius.circular(MediaQuery.of(context).size.width / 2),
            //TODO: replace with avatar
            child: SvgPicture.network(
              "https://parsefiles.back4app.com/tqa1Cgvy94m9L6i7tFTMPXMVYANwy4qELWhzf5Nh/fbee06be8eb6f17186adaf236a69811b_icon_biogut.svg",
              color: Colors.lightGreen,
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.width / 2,
            ),
          ),
          const Padding(padding: EdgeInsets.only(bottom: 20)),
          Text(
            current?.username ?? "",
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const Padding(padding: EdgeInsets.only(bottom: 5)),
          //TODO: replace with actual zip code
          Text(
            "12437",
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const Padding(padding: EdgeInsets.only(bottom: 20)),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: Constants.tileBorderRadius,
            ),
            child: Column(
              //TODO: get values from Backend
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      Languages.of(context)!.profileRecycledItemsText,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Expanded(
                      child: Text("123",
                          style: Theme.of(context).textTheme.bodyText1,
                          textAlign: TextAlign.end),
                    ),
                  ],
                ),
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      Languages.of(context)!.profileSavedItemsText,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Expanded(
                      child: Text("52",
                          style: Theme.of(context).textTheme.bodyText1,
                          textAlign: TextAlign.end),
                    ),
                  ],
                ),
                const Padding(padding: EdgeInsets.only(bottom: 20)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      Languages.of(context)!.profileRankingText,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Expanded(
                      child: Text(
                          "3. ${Languages.of(context)!.profileRankingPlaceText}",
                          style: Theme.of(context).textTheme.bodyText1,
                          textAlign: TextAlign.end),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Padding(padding: EdgeInsets.only(bottom: 20)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton(
                child: Text(Languages.of(context)!.searchHistoryPageTitle),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SearchHistoryPage()),
                ),
              ),
              OutlinedButton(
                child: Text(Languages.of(context)!.bookmarkPageTitle),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BookmarkPage()),
                ),
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.only(bottom: 20)),
          ElevatedButton(
            onPressed: () => _logout(),
            child: Text(Languages.of(context)!.profileLogoutButtonText),
          )
        ],
      ),
    );
  }
}
