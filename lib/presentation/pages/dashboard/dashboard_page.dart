import 'package:flutter/material.dart';
import 'package:recycling_app/presentation/pages/dashboard/widgets/action_tile.dart';
import 'package:recycling_app/presentation/pages/dashboard/widgets/dashboard_tile.dart';
import 'package:recycling_app/presentation/pages/dashboard/widgets/overview_tile.dart';
import 'package:recycling_app/presentation/pages/dashboard/widgets/progress_tile.dart';
import 'package:recycling_app/presentation/pages/dashboard/widgets/text_tile.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const DashboardTile(
              tileContent: ActionTile(),
              padding: EdgeInsets.only(top: 20, right: 20, left: 20),
            ),
            const Padding(padding: EdgeInsets.all(10)),
            const DashboardTile(
              tileContent: ProgressTile(),
              padding: EdgeInsets.only(top: 20, right: 20),
            ),
            const Padding(padding: EdgeInsets.all(10)),
            Row(
              children: const [
                Flexible(child: DashboardTile(tileContent: OverviewTile())),
                Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                Flexible(child: DashboardTile(tileContent: TextTile())),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
