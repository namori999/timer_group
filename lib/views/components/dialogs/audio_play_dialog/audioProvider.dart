import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/models/sound.dart';
import 'package:timer_group/views/components/dialogs/audio_play_dialog/audio_play_button.dart';

Icon icon = const Icon(Icons.play_arrow_rounded);

final audioPlayingProvider = ChangeNotifierProvider((ref) =>
    AudioPlayingNotifier(
        ref, AudioPlayer(), const Icon(Icons.play_arrow_rounded)));

final audioIconProvider =
    Provider((ref) => ref.watch(audioPlayingProvider.notifier).icon);

class AudioPlayingNotifier extends ChangeNotifier {
  AudioPlayingNotifier(this.ref, this.currentPlayer, this.icon) : super();

  Ref ref;
  AudioPlayer currentPlayer;
  var isPlaying = false;
  Icon icon;

  void dispose() {
    currentPlayer.stop();
    currentPlayer.dispose();
    icon = const Icon(Icons.play_arrow_rounded);
    ref.invalidate(audioIconProvider);
  }

  void setCurrentState(bool isPlaying) {
    this.isPlaying = isPlaying;
  }

  void setStartIcon() {
    icon = const Icon(Icons.play_arrow_rounded);
  }

  void setPauseIcon() {
    icon = const Icon(Icons.pause_rounded);
  }

  void play(AudioPlayer player, Sound sound) {
    if (isPlaying) {
      pause();
      AudioPlayButtonState.isSelected = false;
      return;
    }
    currentPlayer.stop();
    currentPlayer = player;
    currentPlayer.setReleaseMode(ReleaseMode.loop);
    currentPlayer.play(UrlSource(sound.url));

    currentPlayer.onPlayerStateChanged.listen((state) {
      if (state == PlayerState.playing) {
        print('playing');
      }
      if (state == PlayerState.paused) {
        print('paused');
      }
    });
    setCurrentState(true);
    setPauseIcon();
    ref.invalidate(audioIconProvider);
  }

  void pause() {
    currentPlayer.pause();
    currentPlayer.dispose();
    setCurrentState(false);
    setStartIcon();
    ref.invalidate(audioIconProvider);
  }
}