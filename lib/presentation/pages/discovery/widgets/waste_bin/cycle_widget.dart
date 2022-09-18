import 'dart:io';

import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:recycling_app/presentation/util/database_classes/waste_bin_category.dart';

class CycleWidget extends StatefulWidget {
  const CycleWidget({Key? key, required this.category}) : super(key: key);

  final WasteBinCategory category;

  @override
  State<CycleWidget> createState() => _CycleWidgetState();
}

class _CycleWidgetState extends State<CycleWidget> {

  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
          child: Row(
            children: [
              Expanded(
                child: CarouselSlider(
                  options: CarouselOptions(
                    viewportFraction: 1,
                    padEnds: false,
                    height: MediaQuery.of(context).size.height,
                    scrollDirection: Axis.vertical,
                    enableInfiniteScroll: false,
                    initialPage: 0,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    },
                  ),
                  items: widget.category.cycleSteps.map((element) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.file(File(element.imagePath)),
                              const Padding(
                                  padding: EdgeInsets.only(bottom: 20)),
                              Text(element.title,
                                  style: Theme.of(context).textTheme.headline1),
                              const Padding(
                                  padding: EdgeInsets.only(bottom: 20)),
                              Text(element.explanation,
                                  style: Theme.of(context).textTheme.bodyText1),
                            ],
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
              const Padding(padding: EdgeInsets.only(right: 10)),
              RotatedBox(
                quarterTurns: 1,
                child: CarouselIndicator(
                  color: Theme.of(context).colorScheme.onSecondary,
                  activeColor: Theme.of(context).colorScheme.secondary,
                  height: 15,
                  count: widget.category.cycleSteps.length,
                  index: _current,
                ),
              ),
            ],
          ),
    );
  }
}
