import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import '../../../i18n/languages.dart';

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
        children: [
          const Padding(padding: EdgeInsets.symmetric(vertical: 20)),
          if (current != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(size),
              child: avatarPicture != null
                  ? CachedNetworkImage(
                imageUrl: avatarPicture.url!,
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
