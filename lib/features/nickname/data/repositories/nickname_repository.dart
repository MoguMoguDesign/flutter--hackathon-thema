import 'package:shared_preferences/shared_preferences.dart';

/// ニックネームの永続化を管理するリポジトリ
///
/// SharedPreferencesを使用してニックネームをローカルストレージに
/// 保存・取得・削除する機能を提供します。
class NicknameRepository {
  /// SharedPreferencesで使用するニックネームのキー
  static const String _nicknameKey = 'nickname';

  /// 保存されているニックネームを取得
  ///
  /// SharedPreferencesからニックネームを読み込みます。
  /// ニックネームが保存されていない場合は null を返します。
  Future<String?> getNickname() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_nicknameKey);
  }

  /// ニックネームを保存
  ///
  /// [nickname] 保存するニックネーム
  ///
  /// 保存に成功した場合は true を返します。
  Future<bool> saveNickname(String nickname) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_nicknameKey, nickname);
  }

  /// ニックネームを削除
  ///
  /// SharedPreferencesからニックネームを削除します。
  /// 削除に成功した場合は true を返します。
  Future<bool> clearNickname() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(_nicknameKey);
  }
}
