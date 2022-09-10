import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:timer_group/views/components/drop_down_button.dart';
import 'package:timer_group/views/configure/theme.dart';

class GroupAddPageFirst extends StatelessWidget {
  GroupAddPageFirst({
    Key? key,
    String? defaultEmail,
    String? defaultPassword,
  })  : emailController = TextEditingController(text: defaultEmail),
        passwordController = TextEditingController(text: defaultPassword),
        super(key: key);

  final ScrollController listViewController = ScrollController();

  final TextEditingController emailController;
  final TextEditingController passwordController;

  var body = <Widget>[];

  List<String> formatList = ["分秒", "時分"];

  Widget spacer() {
    return Column(
      children: const [
        SizedBox(height: 16),
        Divider(
          color: Themes.grayColor,
          height: 2,
        ),
        SizedBox(height: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          autofillHints: const [AutofillHints.email],
          maxLength: 10,
          decoration: const InputDecoration(
            label: Text(
              "タイトル",
              strutStyle: StrutStyle(height: 1.3),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Themes.themeColor, width: 1.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Themes.grayColor, width: 1.0),
            ),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: passwordController,
          keyboardType: TextInputType.visiblePassword,
          autofillHints: const [AutofillHints.email],
          maxLength: 50,
          decoration: const InputDecoration(
            label: Text(
              "説明",
              strutStyle: StrutStyle(height: 1.3),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Themes.themeColor, width: 1.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Themes.grayColor, width: 1.0),
            ),
          ),
        ),
        spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "表示単位",
            ),
            OutlinedDropDownButton(itemList: formatList, type: "TimeFormat",),
          ],
        ),
        spacer(),
      ],
    );
  }

}
