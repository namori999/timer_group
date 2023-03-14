import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timer_group/domein/models/saved_image.dart';
import 'package:timer_group/domein/models/sound.dart';
import 'package:timer_group/domein/models/timer_group_options.dart';
import 'package:timer_group/storage/sqlite.dart';

final pickedFilesRepositoryProvider =
    Provider((ref) => PickedFilesRepository(ref));

class PickedFilesRepository {
  PickedFilesRepository(this.ref);

  static const _pickedFilesDB = SqliteLocalDatabase.pickedFiles;
  final Ref ref;

  Future<List<SavedImage>> getImages() async =>
    await _pickedFilesDB.getImages();

  Future<List<Sound>> getBGMs() async =>
      await _pickedFilesDB.getBGMs();

  Future<List<Sound>> getAlarms() async =>
      await _pickedFilesDB.getAlarms();

  Future<void> addImage(SavedImage savedImage) async {
    await _pickedFilesDB.insertImage(savedImage);
    //ref.refresh(timerGroupOptionsProvider(timerGroupOptions.id));
  }

  Future<void> remove(int id) async {
    await _pickedFilesDB.delete(id);
    //ref.refresh(timerGroupOptionsProvider(id));
  }
}

String getFormatName(TimerGroupOptions options) {
  if (options.timeFormat == TimeFormat.minuteSecond) {
    return '分秒';
  } else {
    return '時分秒';
  }
}
