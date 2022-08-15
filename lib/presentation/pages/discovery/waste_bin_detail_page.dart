import 'package:flutter/material.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';
import 'package:recycling_app/presentation/pages/discovery/widgets/content_widget.dart';
import 'package:recycling_app/presentation/pages/discovery/widgets/cycle_widget.dart';
import 'package:recycling_app/presentation/pages/discovery/widgets/myth_widget.dart';

import '../../util/constants.dart';

class WasteBinDetailPage extends StatefulWidget {
  const WasteBinDetailPage({Key? key, required this.wasteBinName}) : super(key: key);

  final String wasteBinName;

  @override
  State<WasteBinDetailPage> createState() => _WasteBinDetailPageState();
}

class _WasteBinDetailPageState extends State<WasteBinDetailPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.wasteBinName),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Constants.pagePadding, vertical: 30),
          child: Column(
            children: [
              SizedBox(
                height: 40,
                child: TabBar(
                  labelColor: Theme.of(context).colorScheme.onPrimary,
                  unselectedLabelColor: Theme.of(context).colorScheme.onSurface,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).colorScheme.primary),
                  tabs: [
                    Tab(text: Languages.of(context)!.wasteBinContentLabel),
                    Tab(text: Languages.of(context)!.wasteBinCycleLabel),
                    Tab(text: Languages.of(context)!.wasteBinMythLabel),
                  ],
                ),
              ),
              const Expanded(
                child: TabBarView(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: ContentWidget(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: CycleWidget(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: MythWidget(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
