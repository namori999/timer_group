import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/provider/timer_group_options_provider.dart';
import 'package:timer_group/domein/models/timer_group_options.dart';

import '../configure/theme.dart';

class OutlinedDropDownButton extends ConsumerStatefulWidget {
  const OutlinedDropDownButton({
    this.itemList,
    this.type,
    required this.options,
    Key? key,
  }) : super(key: key);

  final List<String>? itemList;
  final String? type;
  final TimerGroupOptions options;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => DropDownButtonState();
}

class DropDownButtonState extends ConsumerState<OutlinedDropDownButton> {
  List<String>? get itemList => widget.itemList;

  String? get type => widget.type;

  TimerGroupOptions get options => widget.options;
  String selectedValue = "";
  TimeFormat? timeFormat;
  String overTime = "false";

  @override
  void initState() {
    super.initState();
    if (options.timeFormat != null) {
      selectedValue =
      (options.timeFormat == TimeFormat.hourMinute) ? '時分秒' : '分秒';
    } else {
      selectedValue = '分秒';
    }
  }

  void addOption() async {
    final optionsProvider = ref.read(timerGroupOptionsRepositoryProvider);

    switch (type) {
      case "TimeFormat":
        timeFormat = selectedValue == "分秒"
            ? TimeFormat.minuteSecond
            : TimeFormat.hourMinute;

        await ref.read(timerGroupOptionsRepositoryProvider).update(
            TimerGroupOptions(
                id: options.id,
                timeFormat: timeFormat,
                overTime: options.overTime));
        break;

      case "overTime":
        overTime = selectedValue == "ON" ? "true" : "false";

        await optionsProvider.update(TimerGroupOptions(
            id: options.id,
            timeFormat: options.timeFormat,
            overTime: overTime));

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
                selectedValue = value!;
                addOption();
                setState(() {});
              },
              dropdownColor: Theme.of(context).cardColor,
              items: itemList?.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem(
                  value: value,
                  child: Center(
                    child: Text(value),
                ),);
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
