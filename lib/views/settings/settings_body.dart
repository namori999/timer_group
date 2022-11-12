import 'package:flutter/cupertino.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:flutter/material.dart';
import 'package:timer_group/views/configure/theme.dart';
import 'package:timer_group/views/settings/settings_count_down_view.dart';

class SettingsBody extends StatelessWidget {
  static Route<SettingsBody> route() {
    return MaterialPageRoute<SettingsBody>(
      settings: const RouteSettings(name: "/detail"),
      builder: (_) => const SettingsBody(),
    );
  }

  const SettingsBody({
    Key? key,
  }) : super(key: key);

  Widget build(BuildContext context) {
    String timerSizeValue = '大';

    return SettingsList(
      sections: [
        SettingsSection(
          title: const Text(
            'サウンド',
            style: TextStyle(color: Themes.grayColor),
          ),
          tiles: <SettingsTile>[
            SettingsTile.navigation(
              leading: Icon(Icons.language),
              title: Text('Language'),
              value: Text('English'),
              onPressed: (context) {
                showDialog(
                  context: context,
                  builder: (context) => const SettingsCountDownView(),
                );
              },
            ),
          ],
        ),
        SettingsSection(
          title: const Text(
            'デザイン変更',
            style: TextStyle(color: Themes.grayColor),
          ),
          tiles: <SettingsTile>[
            SettingsTile.navigation(
              leading: Icon(Icons.font_download_outlined),
              title: Text('タイマーサイズ'),
              value: Text(timerSizeValue),
              onPressed: (context) async {
                final selected = await showDialog(
                  context: context,
                  builder: (context) => const SettingsCountDownView(),
                );
                timerSizeValue = selected;
              },
            ),
          ],
        ),
      ],
    );
  }
}

