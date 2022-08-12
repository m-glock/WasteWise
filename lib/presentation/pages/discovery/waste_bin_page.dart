import 'package:flutter/material.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';
import 'package:recycling_app/presentation/pages/discovery/widgets/content_widget.dart';
import 'package:recycling_app/presentation/pages/discovery/widgets/cycle_widget.dart';
import 'package:recycling_app/presentation/pages/discovery/widgets/myth_widget.dart';
import 'package:recycling_app/presentation/util/waste_bin.dart';

class WasteBinPage extends StatefulWidget {
  const WasteBinPage({Key? key, required this.wasteBin}) : super(key: key);

  final WasteBin wasteBin;

  @override
  State<WasteBinPage> createState() => _WasteBinPageState();
}

class _WasteBinPageState extends State<WasteBinPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(Languages.of(context)!.wasteBinNames[widget.wasteBin]!),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(15, 30, 15, 0),
          child: Column(
            children: [
              SizedBox(
                height: 40,
                child: TabBar(
                  indicatorColor: Theme.of(context).colorScheme.primary,
                  labelColor: Theme.of(context).colorScheme.onSurface,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).colorScheme.surface),
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
