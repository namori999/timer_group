import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/groupOptionsProvider.dart';
import 'package:timer_group/domein/models/timer_group_options.dart';

import '../configure/theme.dart';

class OutlinedDropDownButton extends ConsumerStatefulWidget {
  const OutlinedDropDownButton({
    this.itemList,
    required this.type,
    required this.timerGroupTitle,
    Key? key,
  }) : super(key: key);

  final List<String>? itemList;
  final String type;
  final String timerGroupTitle;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => DropDownButtonState();
}

class DropDownButtonState extends ConsumerState<OutlinedDropDownButton> {
  List<String>? get itemList => widget.itemList;

  String get title => widget.timerGroupTitle;

  String get type => widget.type;
  String selectedValue = "";
  TimeFormat? timeFormat;
  bool overTime = false;

  @override
  void initState() {
    super.initState();
    selectedValue = (itemList == null) ? "" : itemList!.first;
  }

  void addOption() async {
    switch (type) {
      case "TimeFormat":
        timeFormat = selectedValue == "分秒"
            ? TimeFormat.minuteSecond
            : TimeFormat.hourMinute;

        await ref
            .read(timerGroupOptionsRepositoryProvider)
            .addOption(TimerGroupOptions(title: title, timeFormat: timeFormat));
        break;

      case "overTime":
        overTime = selectedValue == "ON" ? true : false;

        await ref
            .read(timerGroupOptionsRepositoryProvider)
            .addOption(TimerGroupOptions(title: title, overTime: overTime));
        break;
    }
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
                addOption();
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
