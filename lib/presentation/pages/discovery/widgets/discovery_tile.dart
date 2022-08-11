import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DiscoveryTile extends StatefulWidget {
  const DiscoveryTile(
      {Key? key,
      required this.icon,
      required this.title,
      required this.subtitle,
      required this.destinationPage})
      : super(key: key);

  final IconData icon;
  final String title;
  final String subtitle;
  final Widget destinationPage;

  @override
  State<DiscoveryTile> createState() => _DiscoveryTileState();
}

class _DiscoveryTileState extends State<DiscoveryTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => widget.destinationPage),
        );
      },
      child: Container(
        height: 100,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              Icon(
                widget.icon,
                size: 50,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 5)),
                      Text(
                        widget.subtitle,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                ),
              ),
              const Icon(FontAwesomeIcons.angleRight),
            ],
          ),
        ),
      ),
    );
  }
}
