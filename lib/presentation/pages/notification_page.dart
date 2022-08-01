import 'package:flutter/material.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Languages.of(context)!.notificationPageName),
      ),
      body: const Center(),
    );
  }
}