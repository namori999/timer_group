import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../configure/theme.dart';

class OutlinedDropDownButton extends ConsumerStatefulWidget {
  const OutlinedDropDownButton({
    this.itemList,
    required this.type,
    Key? key,
  }) : super(key: key);


  final List<String>? itemList;
  final String type;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => DropDownButtonState();
}

class DropDownButtonState extends ConsumerState<OutlinedDropDownButton> {
  List<String>? get itemList => widget.itemList;
  String get type => widget.type;
  String selectedValue = "";

  @override
  void initState() {
    super.initState();
    selectedValue = (itemList == null) ? "" : itemList!.first;

  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: Themes.grayColor, width: 1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: SizedBox(
        width: 130,
        height: 40,
        child: Center(
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              iconSize: 0.0,
              value: selectedValue,
              onChanged: (String? value) {
                setState(() {
                  selectedValue = value!;
                });
              },
              items: itemList?.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem(
                    value: value, child: Center(child: Text(value)));
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
