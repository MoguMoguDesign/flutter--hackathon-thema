import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/nickname_repository.dart';
import '../../service/user_id_service.dart';

part 'nickname_provider.g.dart';

/// ユーザーIDサービスのプロバイダー
///
/// UserIdServiceのインスタンスを提供します。
/// keepAlive: true で、アプリのライフサイクル中にインスタンスを保持します。
@Riverpod(keepAlive: true)
UserIdService userIdService(Ref ref) {
  return UserIdService();
}

/// ニックネームリポジトリのプロバイダー
///
/// NicknameRepositoryのインスタンスを提供します。
/// keepAlive: true で、アプリのライフサイクル中にインスタンスを保持します。
@Riverpod(keepAlive: true)
NicknameRepository nicknameRepository(Ref ref) {
  return NicknameRepository(userIdService: ref.watch(userIdServiceProvider));
}

/// ニックネームの状態を管理するプロバイダー
///
/// アプリ起動時に Firebase Firestore からニックネームを読み込み、
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
  /// Firestoreから保存されているニックネームを読み込みます。
  /// ニックネームが保存されていない場合は null を返します。
  /// エラーが発生した場合もnullを返します（初回アクセスの場合が多い）。
  @override
  Future<String?> build() async {
    try {
      final model = await _repository.getNickname();
      return model?.nickname;
    } catch (e) {
      // エラーログを出力
      // 初回アクセス時やドキュメントが存在しない場合はエラーが発生する可能性があるが、
      // これは正常なケースなのでnullを返す
      return null;
    }
  }

  /// ニックネームを設定して永続化
  ///
  /// [nickname] 設定するニックネーム
  ///
  /// Firebase Firestore に保存し、状態を更新します。
  Future<void> setNickname(String nickname) async {
    await _repository.saveNickname(nickname);
    state = AsyncData(nickname);
  }

  /// ニックネームをクリア
  ///
  /// Firebase Firestore からニックネームを削除し、状態を null に更新します。
  Future<void> clearNickname() async {
    await _repository.clearNickname();
    state = const AsyncData(null);
  }
}
