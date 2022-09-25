import 'package:flutter/material.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';
import 'package:recycling_app/presentation/pages/discovery/widgets/waste_bin/content_widget.dart';
import 'package:recycling_app/presentation/pages/discovery/widgets/waste_bin/cycle_widget.dart';
import 'package:recycling_app/presentation/pages/discovery/widgets/waste_bin/myth_widget.dart';
import 'package:recycling_app/presentation/util/database_classes/waste_bin_category.dart';

import '../../util/constants.dart';

class WasteBinDetailPage extends StatelessWidget {

  final WasteBinCategory wasteBin;
  int controllerLength = 1;

  WasteBinDetailPage({Key? key, required this.wasteBin})
      : super(key: key){
    if(wasteBin.cycleSteps.isNotEmpty) controllerLength++;
    if(wasteBin.myths.isNotEmpty) controllerLength++;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: controllerLength,
      child: Scaffold(
        appBar: AppBar(
          title: Text(wasteBin.title),
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
                    borderRadius: BorderRadius.circular(30),
                    color: Theme.of(context).colorScheme.primary.withAlpha(200),
                  ),
                  labelStyle: Theme.of(context).textTheme.headline2,
                  tabs: [
                    Tab(text: Languages.of(context)!.wasteBinContentLabel),
                    if(wasteBin.cycleSteps.isNotEmpty)
                      Tab(text: Languages.of(context)!.wasteBinCycleLabel),
                    if(wasteBin.myths.isNotEmpty)
                      Tab(text: Languages.of(context)!.wasteBinMythLabel),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child:
                          ContentWidget(category: wasteBin),
                    ),
                    if(wasteBin.cycleSteps.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: CycleWidget(category: wasteBin),
                      ),
                    if(wasteBin.myths.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: MythWidget(category: wasteBin),
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
