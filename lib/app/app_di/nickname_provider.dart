import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'nickname_provider.g.dart';

/// 一時的なニックネーム管理用Provider
///
/// NOTE: これは一時的な実装です
/// Issue #10 完了時に shared_preferences を使用した永続化実装に置き換えられます
///
/// 現在の実装:
/// - メモリ上でのみニックネームを保持
/// - アプリ再起動時にニックネームが消失
///
/// 将来の実装 (Issue #10):
/// - SharedPreferences による永続化
/// - アプリ再起動後もニックネームを保持
///
/// TODO(#10): Issue #10 完了後、このファイルを削除して
/// lib/features/nickname/presentation/providers/nickname_provider.dart に置き換える
@Riverpod(keepAlive: true)
class TemporaryNickname extends _$TemporaryNickname {
  /// ニックネームの初期状態を構築
  ///
  /// デフォルトでは null（未設定）を返します
  @override
  String? build() {
    return null;
  }

  /// ニックネームを設定
  ///
  /// [nickname] 設定するニックネーム
  void setNickname(String nickname) {
    state = nickname;
  }

  /// ニックネームをクリア
  ///
  /// 状態を null（未設定）に戻します
  void clearNickname() {
    state = null;
  }
}
