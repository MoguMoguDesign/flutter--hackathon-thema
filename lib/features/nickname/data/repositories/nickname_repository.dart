import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutterhackthema/features/nickname/data/models/nickname_model.dart';
import 'package:flutterhackthema/features/nickname/service/user_id_service.dart';
import 'package:flutterhackthema/shared/data/repositories/firestore_repository.dart';

/// ニックネームの永続化を管理するリポジトリ
///
/// Firebase Firestoreを使用してニックネームをクラウドストレージに
/// 保存・取得・削除する機能を提供します。
///
/// ユーザーIDはUserIdServiceで管理され、Firestoreのドキュメントキーとして使用されます。
///
/// Firestoreデータ構造:
/// ```
/// users (collection)
///   └── {userId} (document)
///       ├── nickname: String
///       └── updatedAt: Timestamp
/// ```
///
/// 使用例:
/// ```dart
/// final repository = NicknameRepository(userIdService: UserIdService());
/// final model = await repository.getNickname();
/// ```
class NicknameRepository extends FirestoreRepository<NicknameModel> {
  /// ユーザーID管理サービス
  final UserIdService _userIdService;

  /// NicknameRepositoryを作成
  ///
  /// [userIdService] ユーザーID管理サービス
  /// [firestore] Firestoreインスタンス（テスト用）
  NicknameRepository({
    required UserIdService userIdService,
    FirebaseFirestore? firestore,
  }) : _userIdService = userIdService,
       super(collectionPath: 'users') {
    if (firestore != null) {
      // テスト用にFirestoreインスタンスを差し替え
      _testFirestore = firestore;
    }
  }

  FirebaseFirestore? _testFirestore;

  @override
  FirebaseFirestore get firestore => _testFirestore ?? super.firestore;

  /// Firestoreドキュメントからモデルに変換
  ///
  /// [snapshot] Firestoreドキュメントスナップショット
  ///
  /// Returns: NicknameModel
  @override
  NicknameModel fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    if (data == null) {
      throw StateError('Document data is null');
    }

    return NicknameModel.fromJson(data);
  }

  /// モデルからFirestoreドキュメントに変換
  ///
  /// [data] NicknameModel
  ///
  /// Returns: Firestoreに保存するMapデータ
  @override
  Map<String, dynamic> toFirestore(NicknameModel data) {
    return data.toJson();
  }

  /// 保存されているニックネームを取得
  ///
  /// Firestoreからニックネームを読み込みます。
  /// ニックネームが保存されていない場合は null を返します。
  ///
  /// Returns: NicknameModel、存在しない場合はnull
  ///
  /// Throws:
  /// - [FirebaseException] Firestore操作でエラーが発生した場合
  Future<NicknameModel?> getNickname() async {
    try {
      final String userId = await _userIdService.getUserId();
      return await read(userId);
    } on FirebaseException catch (e) {
      throw Exception('ニックネームの取得に失敗しました: ${e.message}');
    } catch (e) {
      throw Exception('予期しないエラーが発生しました: $e');
    }
  }

  /// ニックネームを保存
  ///
  /// [nickname] 保存するニックネーム
  ///
  /// Firestoreに保存します。既にニックネームが存在する場合は上書きします。
  ///
  /// Returns: 保存に成功した場合はtrue
  ///
  /// Throws:
  /// - [FirebaseException] Firestore操作でエラーが発生した場合
  Future<bool> saveNickname(String nickname) async {
    try {
      final String userId = await _userIdService.getUserId();
      final model = NicknameModel(
        nickname: nickname,
        updatedAt: DateTime.now(),
      );

      // 既存のドキュメントがあるか確認
      final existing = await read(userId);

      if (existing == null) {
        // 新規作成
        await create(model, docId: userId);
      } else {
        // 更新
        await update(userId, model);
      }

      return true;
    } on FirebaseException catch (e) {
      throw Exception('ニックネームの保存に失敗しました: ${e.message}');
    } catch (e) {
      throw Exception('予期しないエラーが発生しました: $e');
    }
  }

  /// ニックネームを削除
  ///
  /// Firestoreからニックネームを削除します。
  ///
  /// Returns: 削除に成功した場合はtrue
  ///
  /// Throws:
  /// - [FirebaseException] Firestore操作でエラーが発生した場合
  Future<bool> clearNickname() async {
    try {
      final String userId = await _userIdService.getUserId();
      await delete(userId);
      return true;
    } on FirebaseException catch (e) {
      throw Exception('ニックネームの削除に失敗しました: ${e.message}');
    } catch (e) {
      throw Exception('予期しないエラーが発生しました: $e');
    }
  }
}
