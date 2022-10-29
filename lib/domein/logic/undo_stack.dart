import 'dart:async';

typedef UndoCallback = FutureOr<void> Function();

/// 復元するコールバックを保持する型
class UndoStack {
  final _list = <UndoCallback>[];

  void push(UndoCallback value) => _list.add(value);

  UndoCallback _pop() => _list.removeLast();

  Future<void> undo() async {
    await _pop().call();
  }

  bool get isEmpty => _list.isEmpty;

  bool get isNotEmpty => _list.isNotEmpty;

  @override
  String toString() => _list.toString();
}
