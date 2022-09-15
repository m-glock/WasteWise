import 'package:flutter/material.dart';
import 'package:recycling_app/presentation/i18n/languages.dart';
import 'package:recycling_app/presentation/pages/neighborhood/widgets/forum_entry_widget.dart';
import 'package:recycling_app/presentation/util/database_classes/forum_entry.dart';

import '../../util/constants.dart';
import '../../util/custom_icon_button.dart';

class ThreadPage extends StatefulWidget {
  const ThreadPage({Key? key, required this.forumEntry}) : super(key: key);

  final ForumEntry forumEntry;

  @override
  State<ThreadPage> createState() => _ThreadPageState();
}

class _ThreadPageState extends State<ThreadPage> {
  List<String> test = ["evfknse", "fvpwejvpesodc", "fwenpfciqwjed"];
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Languages.of(context)!.threadPageTitle),
      ),
      body: Padding(
        padding: EdgeInsets.all(Constants.pagePadding),
        child: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ForumEntryWidget(
                          forumEntry: widget.forumEntry,
                          showButton: false,
                        ),
                        const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: test.length,
                          itemBuilder: (BuildContext context, int index) {
                            String example = test[index];
                            return Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surface,
                                  borderRadius: Constants.tileBorderRadius,
                                ),
                                padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                width: double.infinity,
                                child: Text(example),
                            );
                          },
                        ),
                      ],
                    )),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
            Container(
              color: Theme.of(context).colorScheme.surface,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      autocorrect: false,
                      decoration: InputDecoration(
                        fillColor: Theme.of(context).colorScheme.surface,
                        hintText: Languages.of(context)!.threadReplyHintText,
                        filled: true,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  CustomIconButton(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    icon: const Icon(Icons.send),
                    onPressed: () => {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
