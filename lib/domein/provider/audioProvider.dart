import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/models/sound.dart';

AudioPlayer player = AudioPlayer();
Icon icon = const Icon(Icons.play_arrow_rounded);

final audioPlayingProvider =
    StateNotifierProvider((ref) => AudioPlayingNotifier(player));

class AudioPlayingNotifier extends StateNotifier {
  var player;
  AudioPlayingNotifier(this.player) : super(player);

  void pause() {
    player.pause();
  }

  void play(Sound sound) {
    player.setReleaseMode(ReleaseMode.loop);
    if (player.state == PlayerState.playing) {
      player.pause();
    }
    player.play(UrlSource(sound.url));
  }

  String getPlayingAudioId() {
    return player.playerId;
  }

  Icon getCurrentIcon() {
    return icon;
  }
}
