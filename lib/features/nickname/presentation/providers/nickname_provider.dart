import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/nickname_repository.dart';

part 'nickname_provider.g.dart';

/// ニックネームリポジトリのプロバイダー
///
/// NicknameRepositoryのインスタンスを提供します。
/// keepAlive: true で、アプリのライフサイクル中にインスタンスを保持します。
@Riverpod(keepAlive: true)
class NicknameRepositoryNotifier extends _$NicknameRepositoryNotifier {
  /// リポジトリインスタンスを構築
  @override
  NicknameRepository build() {
    return NicknameRepository();
  }
}

/// ニックネームの状態を管理するプロバイダー
///
/// アプリ起動時に SharedPreferences からニックネームを読み込み、
/// 状態を管理します。
///
/// 使用例:
/// ```dart
/// // ニックネームを取得
/// final nicknameAsync = ref.watch(nicknameNotifierProvider);
///
/// // ニックネームを設定
/// await ref.read(nicknameNotifierProvider.notifier).setNickname('ユーザー名');
/// ```
@Riverpod(keepAlive: true)
class NicknameNotifier extends _$NicknameNotifier {
  /// ニックネームリポジトリを取得
  NicknameRepository get _repository => ref.read(nicknameRepositoryProvider);

  /// ニックネームの初期状態を構築
  ///
  /// SharedPreferences から保存されているニックネームを読み込みます。
  /// ニックネームが保存されていない場合は null を返します。
  @override
  Future<String?> build() async {
    return _repository.getNickname();
  }

  /// ニックネームを設定して永続化
  ///
  /// [nickname] 設定するニックネーム
  ///
  /// SharedPreferences に保存し、状態を更新します。
  Future<void> setNickname(String nickname) async {
    await _repository.saveNickname(nickname);
    state = AsyncData(nickname);
  }

  /// ニックネームをクリア
  ///
  /// SharedPreferences からニックネームを削除し、状態を null に更新します。
  Future<void> clearNickname() async {
    await _repository.clearNickname();
    state = const AsyncData(null);
  }
}
