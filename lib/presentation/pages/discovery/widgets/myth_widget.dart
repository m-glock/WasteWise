import 'package:flutter/material.dart';
import 'package:recycling_app/presentation/pages/discovery/widgets/myth_list_widget.dart';

class MythWidget extends StatefulWidget {
  const MythWidget({Key? key}) : super(key: key);

  @override
  State<MythWidget> createState() => _MythWidgetState();
}

class _MythWidgetState extends State<MythWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: ListView(
        children: const [
          //TODO replace with actual text
          MythListWidget(
              question: "Question 1",
              answer:
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
                  "Donec porta orci convallis arcu aliquet, quis fringilla sapien semper. "
                  "Suspendisse dapibus nibh et lacus scelerisque sollicitudin. "
                  "Nunc pellentesque aliquet massa pulvinar accumsan. "
                  "Duis vitae eros vel urna sollicitudin malesuada a vel sapien. "),
          MythListWidget(
              question: "Question 2",
              answer:
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
                  "Donec porta orci convallis arcu aliquet, quis fringilla sapien semper. "
                  "Suspendisse dapibus nibh et lacus scelerisque sollicitudin. "
                  "Nunc pellentesque aliquet massa pulvinar accumsan. "
                  "Duis vitae eros vel urna sollicitudin malesuada a vel sapien. "),
          MythListWidget(
              question: "Question 2",
              answer:
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
                  "Donec porta orci convallis arcu aliquet, quis fringilla sapien semper. "
                  "Suspendisse dapibus nibh et lacus scelerisque sollicitudin. "
                  "Nunc pellentesque aliquet massa pulvinar accumsan. "
                  "Duis vitae eros vel urna sollicitudin malesuada a vel sapien. "),
        ],
      ),
    );
  }
}
