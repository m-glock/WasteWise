import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:recycling_app/presentation/pages/profile/bookmark_page.dart';
import 'package:recycling_app/presentation/pages/profile/search_history_page.dart';

import '../../../i18n/languages.dart';
import '../../../util/constants.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget(
      {Key? key, required this.authenticated, this.introView = false})
      : super(key: key);

  final Function authenticated;
  final bool introView;

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
    ParseUser currentUser = await ParseUser.currentUser() as ParseUser;
    setState(() {
      current = currentUser;
    });
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
    ParseFile? avatarPicture = current?.get("avatar_picture");
    double size = MediaQuery.of(context).size.width / 2;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (current != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(size),
              child: avatarPicture != null
                  ? SvgPicture.network(
                      avatarPicture.url!,
                      width: size,
                      height: size,
                    )
                  : Container(
                      color: Colors.black12,
                      width: size,
                      height: size,
                      child: Icon(
                        FontAwesomeIcons.user,
                        size: MediaQuery.of(context).size.width / 3,
                      ),
                    ),
            ),
          const Padding(padding: EdgeInsets.only(bottom: 20)),
          Text(
            current?.username ?? "",
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const Padding(padding: EdgeInsets.only(bottom: 5)),
          Text(
            current?.get("zip_code") ?? "",
            style: Theme.of(context).textTheme.bodyText1,
          ),
          if (!widget.introView) ...[
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
                            "3 ${Languages.of(context)!.profileRankingPlaceText}",
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
                    MaterialPageRoute(
                        builder: (context) => const BookmarkPage()),
                  ),
                ),
              ],
            ),
          ],
          const Padding(padding: EdgeInsets.only(bottom: 20)),
          ElevatedButton(
            onPressed: () => _logout(),
            child: Text(Languages.of(context)!.profileLogoutButtonText),
          ),
        ],
      ),
    );
  }
}
