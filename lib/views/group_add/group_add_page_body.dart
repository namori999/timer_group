import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/views/configure/theme.dart';
import 'package:timer_group/views/group_add/group_add_page_timer_list.dart';

class GroupAddPageBody extends ConsumerStatefulWidget {
  GroupAddPageBody({
    Key key,
    String defaultEmail,
    String defaultPassword,
  })  : emailController = TextEditingController(text: defaultEmail),
        passwordController = TextEditingController(text: defaultPassword),
        super(key: key);

  final ScrollController listViewController = ScrollController();

  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => GroupPageBodyState();
}

class GroupPageBodyState extends ConsumerState<GroupAddPageBody> {
  get emailController => widget.emailController;

  get passwordController => widget.passwordController;

  var body = <Widget>[];

  @override
  void initState() {
    super.initState();
    body.add(firstStep());
    body.add(nextStepButton());
  }

  void nextStep() {
    body.clear();
    body.add(firstStep());
    body.add(secondStep());
  }

  Widget nextStepButton() {
    return IconButton(
      onPressed: () => setState(() {
        nextStep();
      }),
      iconSize: 80,
      icon: const Icon(
        Icons.expand_circle_down_outlined,
        color: Themes.grayColor,
      ),
    );
  }

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

  Widget firstStep() {
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
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
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
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(130, 40),
                foregroundColor: Themes.grayColor,
                side: const BorderSide(
                  color: Themes.grayColor,
                ),
              ),
              child: const Text(
                '分秒',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              onPressed: () => print('Clicked'),
            ),
          ],
        ),
        spacer(),
      ],
    );
  }

  Widget secondStep() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              "タイマー",
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        const GroupAddPageTimerList(),
        spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              '合計時間',
            ),
            Padding(
              padding: EdgeInsets.only(right: 32),
              child: Text(
                '20分00秒',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "オーバータイム",
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(130, 40),
                foregroundColor: Themes.grayColor,
                side: const BorderSide(
                  color: Themes.grayColor,
                ),
              ),
              child: const Text(
                'OFF',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              onPressed: () => print('Clicked'),
            ),
          ],
        ),
        spacer(),
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {},
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.add_circle_outline,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  'タイマーグループを追加',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: body,
    );
  }
}
