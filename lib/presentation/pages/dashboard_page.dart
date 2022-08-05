import 'package:flutter/material.dart';
import 'package:recycling_app/presentation/widgets/dashboard_tile.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 15
        ),
        child: Center(
          child: Column(
            children: [
              const DashboardTile(),
              const Padding(padding: EdgeInsets.all(10)),
              const DashboardTile(),
              const Padding(padding: EdgeInsets.all(10)),
              Row(
                children: const [
                  Flexible(child: DashboardTile()),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                  Flexible(child: DashboardTile()),
                ],
              ),
            ],
          ),
        ),
      )
    );
  }
}