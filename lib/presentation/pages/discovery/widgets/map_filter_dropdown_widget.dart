import 'package:flutter/material.dart';

import '../../../i18n/languages.dart';

class MapFilterDropdownWidget extends StatefulWidget {
  const MapFilterDropdownWidget({Key? key, required this.dropdownValues})
      : super(key: key);

  final List<String> dropdownValues;

  @override
  State<MapFilterDropdownWidget> createState() =>
      _MapFilterDropdownWidgetState();
}

class _MapFilterDropdownWidgetState extends State<MapFilterDropdownWidget> {
  late String dropdownDefault = widget.dropdownValues.first;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(Languages.of(context)!.filterLabelItemType),
        const Padding(padding: EdgeInsets.only(right: 5)),
        Expanded(
          child: DropdownButton<String>(
            isExpanded: true,
            value: dropdownDefault,
            onChanged: (String? newValue) {
              setState(() {
                dropdownDefault = newValue!;
              });
            },
            items: widget.dropdownValues
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
