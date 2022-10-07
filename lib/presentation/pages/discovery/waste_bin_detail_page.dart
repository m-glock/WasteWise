import 'package:flutter/material.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';
import 'package:recycling_app/presentation/pages/discovery/widgets/waste_bin/content_widget.dart';
import 'package:recycling_app/presentation/pages/discovery/widgets/waste_bin/cycle_widget.dart';
import 'package:recycling_app/presentation/pages/discovery/widgets/waste_bin/myth_widget.dart';

import '../../../model_classes/waste_bin_category.dart';
import '../../../logic/util/constants.dart';

class WasteBinDetailPage extends StatelessWidget {

  final WasteBinCategory wasteBin;

  const WasteBinDetailPage({Key? key, required this.wasteBin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return wasteBin.cycleSteps.isEmpty && wasteBin.myths.isEmpty
        ? Scaffold(
            appBar: AppBar(
              title: Text(wasteBin.title),
            ),
            body: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ContentWidget(category: wasteBin),
              ),
          )
        : DefaultTabController(
            length: 3,
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
                        unselectedLabelColor:
                            Theme.of(context).colorScheme.onSurface,
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withAlpha(200),
                        ),
                        labelStyle: Theme.of(context).textTheme.headline2,
                        tabs: [
                          Tab(
                              text:
                                  Languages.of(context)!.wasteBinContentLabel),
                          Tab(text: Languages.of(context)!.wasteBinCycleLabel),
                          Tab(text: Languages.of(context)!.wasteBinMythLabel),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: ContentWidget(category: wasteBin),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 0),
                            child: CycleWidget(category: wasteBin),
                          ),
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
