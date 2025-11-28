import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'gourmet_provider.g.dart';

/// グルメメモの状態を管理するProvider
///
/// 使用例:
/// ```dart
/// final memos = ref.watch(gourmetMemosProvider);
/// ```
@riverpod
class GourmetMemos extends _$GourmetMemos {
  @override
  List<String> build() {
    // 初期状態: サンプルメモ
    return [
      'おいしいラーメン店を発見！',
      '新しいカフェがオープン',
    ];
  }

  /// メモを追加
  void addMemo(String memo) {
    state = [...state, memo];
  }

  /// メモを削除
  void removeMemo(int index) {
    state = [
      ...state.sublist(0, index),
      ...state.sublist(index + 1),
    ];
  }
}
