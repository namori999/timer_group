import 'package:flutter/cupertino.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:flutter/material.dart';
import 'package:timer_group/storage/preferances.dart';

/*
class QuizOrderSettingItem extends AbstractSettingsTile {
  const QuizOrderSettingItem({
    Key key,
    this.prefs,
    this.onSelected,
  }) : super(key: key);
  final LocalSharedPreferences prefs;
  final Function(QuizOrderMode? mode) onSelected;

  static String modeString(QuizOrderMode mode) {
    switch (mode) {
      case QuizOrderMode.shuffle:
        return 'シャッフル';
      case QuizOrderMode.fixed:
        return '固定';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SettingsTile.navigation(
      leading: const Icon(Icons.mode_edit_outline),
      title: const Text('表示順'),
      value: Text(modeString(prefs.getQuizOrderMode())),
      onPressed: (context) async {
        final mode = await showDialog<QuizOrderMode>(
          context: context,
          builder: (context) => const _QuizOrderSettingDialog(),
        );
        onSelected(mode);
      },
    );
  }
}

class _QuizOrderSettingDialog extends StatelessWidget {
  const _QuizOrderSettingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('クイズの表示順'),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      children: [
        const Text('クイズの表示順設定を選んでください。'),
        const SizedBox(height: 24),
        OutlinedButton(
          child: const Text('シャッフル'),
          onPressed: () => Navigator.of(context).pop(QuizOrderMode.shuffle),
        ),
        const Text('プレイできるクイズをランダムな順序で表示します'),
        const SizedBox(height: 24),
        OutlinedButton(
          child: const Text('固定'),
          onPressed: () => Navigator.of(context).pop(QuizOrderMode.fixed),
        ),
        const Text('常に同じ順番で表示します'),
      ],
    );
  }
}

 */