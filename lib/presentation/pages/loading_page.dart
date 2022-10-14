import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:recycling_app/logic/services/data_service.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';
import 'package:recycling_app/presentation/pages/home_page.dart';

import '../../logic/util/constants.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {

  String? languageCode;
  String? municipalityId;

  @override
  void initState() {
    super.initState();
    DataService dataService = Provider.of<DataService>(context, listen: false);
    dataService.init(context).then((value) {
      Route route = MaterialPageRoute(builder: (context) => const HomePage());
      Navigator.pushReplacement(context, route);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: Constants.pagePadding, horizontal: 40),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/icons/logo.svg",
                width: 170,
                height: 170,
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              Text(
                Languages.of(context)!.waitingForInitializationText,
                style: Theme.of(context).textTheme.headline1,
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 15)),
              const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}