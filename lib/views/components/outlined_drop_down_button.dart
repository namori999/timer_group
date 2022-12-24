import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/provider/timer_group_options_provider.dart';
import 'package:timer_group/domein/provider/timer_group_provider.dart';
import 'package:timer_group/domein/models/timer_group_options.dart';

import '../configure/theme.dart';

class OutlinedDropDownButton extends ConsumerStatefulWidget {
  const OutlinedDropDownButton({
    this.itemList,
    required this.type,
    required this.title,
    Key? key,
  }) : super(key: key);

  final List<String>? itemList;
  final String type;
  final String title;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => DropDownButtonState();
}

class DropDownButtonState extends ConsumerState<OutlinedDropDownButton> {
  List<String>? get itemList => widget.itemList;

  String get title => widget.title;

  String get type => widget.type;
  String selectedValue = "";
  TimeFormat? timeFormat;
  String overTime = "false";

  @override
  void initState() {
    super.initState();
    selectedValue = (itemList == null) ? "" : itemList!.first;
  }

  void addOption() async {
    final id = await ref.read(timerGroupRepositoryProvider).getId(title);
    final optionsProvider = ref.read(timerGroupOptionsRepositoryProvider);
    final option = await optionsProvider.getOptions(id);

    switch (type) {
      case "TimeFormat":
        timeFormat = selectedValue == "分秒"
            ? TimeFormat.minuteSecond
            : TimeFormat.hourMinute;

        await ref.read(timerGroupOptionsRepositoryProvider).update(
            TimerGroupOptions(
                id: id,
                title: option.title,
                timeFormat: timeFormat,
                overTime: option.overTime)
        );
        break;

      case "overTime":
        overTime = selectedValue == "ON" ? "true" : "false";

        await optionsProvider.update(
            TimerGroupOptions(
                id: id,
                title: option.title,
                timeFormat: option.timeFormat,
                overTime: overTime)
        );

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
              iconSize: 5.0,
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
