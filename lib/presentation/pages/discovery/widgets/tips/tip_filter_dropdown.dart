import 'package:flutter/material.dart';

import '../../../../i18n/languages.dart';

class TipFilterDropdown extends StatefulWidget {
  const TipFilterDropdown({
    Key? key,
    required this.isWasteBinType,
    required this.filterTipList,
    required this.filterOptions,
    required this.defaultFilterValue,
  }) : super(key: key);

  final bool isWasteBinType;
  final Function(String, bool) filterTipList;
  final List<String> filterOptions;
  final String defaultFilterValue;

  @override
  State<TipFilterDropdown> createState() => _TipFilterDropdownState();
}

class _TipFilterDropdownState extends State<TipFilterDropdown> {
  late String filterValue;

  @override
  void initState() {
    super.initState();
    filterValue = widget.defaultFilterValue;
  }

  void _setFilterValue(String value){
    setState(() {
      filterValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.isWasteBinType
                ? Languages.of(context)!.dropdownWasteBinLabel
                : Languages.of(context)!.dropdownTipTypeLabel,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          DropdownButton<String>(
            isExpanded: true,
            value: filterValue,
            onChanged: (String? newValue) {
              _setFilterValue(newValue!);
              widget.filterTipList(newValue, widget.isWasteBinType);
            },
            items: widget.filterOptions.map<DropdownMenuItem<String>>((title) {
              return DropdownMenuItem<String>(
                value: title,
                child: Text(title),
              );
            }).toList(),
          ),
        ],
    );
  }
}
