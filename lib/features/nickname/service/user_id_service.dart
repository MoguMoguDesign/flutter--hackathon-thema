import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

/// ユーザーID管理サービス
///
/// デバイスごとに一意のユーザーIDを生成・管理します。
/// UUIDv4を使用してランダムなIDを生成し、SharedPreferencesに永続化します。
///
/// 注意: アプリ削除時にユーザーIDは失われます。
/// 将来的にはFirebase Authenticationへの移行を推奨します。
///
/// 使用例:
/// ```dart
/// final service = UserIdService();
/// final userId = await service.getUserId();
/// ```
class UserIdService {
  /// SharedPreferencesで使用するユーザーIDのキー
  static const String _userIdKey = 'user_id';

  /// UUID生成インスタンス
  static const Uuid _uuid = Uuid();

  /// ユーザーIDを取得（存在しない場合は生成）
  ///
  /// SharedPreferencesからユーザーIDを読み込みます。
  /// IDが存在しない場合は、UUIDv4形式で新規生成しSharedPreferencesに保存します。
  ///
  /// Returns: ユーザーID（UUIDv4形式の文字列）
  ///
  /// 例:
  /// ```dart
  /// final userId = await getUserId();
  /// print(userId); // "550e8400-e29b-41d4-a716-446655440000"
  /// ```
  Future<String> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString(_userIdKey);

    if (userId == null) {
      userId = _uuid.v4();
      await prefs.setString(_userIdKey, userId);
    }

    return userId;
  }

  /// ユーザーIDをクリア（テスト用）
  ///
  /// SharedPreferencesからユーザーIDを削除します。
  /// この操作は主にテスト環境で使用されます。
  ///
  /// 本番環境では通常使用しないでください。
  ///
  /// Returns: 削除に成功した場合はtrue
  Future<bool> clearUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(_userIdKey);
  }
}
