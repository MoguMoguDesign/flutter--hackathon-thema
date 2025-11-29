import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

import 'package:flutterhackthema/shared/data/repositories/firestore_repository.dart';
import '../models/haiku_model.dart';

/// 俳句データのFirestoreリポジトリ
///
/// Firestoreの`haikus`コレクションに対するCRUD操作を提供します。
/// [FirestoreRepository]を継承し、俳句特有のロジックを実装します。
class HaikuRepository extends FirestoreRepository<HaikuModel> {
  /// 俳句リポジトリを作成する
  HaikuRepository() : super(collectionPath: 'haikus');

  final Logger _logger = Logger();

  @override
  Future<String> create(HaikuModel data, {String? docId}) async {
    final stopwatch = Stopwatch()..start();

    try {
      _logger.i('Creating haiku: ${data.firstLine}');
      final id = await super.create(data, docId: docId);
      stopwatch.stop();
      _logger.i(
        'Haiku created successfully: $id (${stopwatch.elapsedMilliseconds}ms)',
      );
      return id;
    } catch (e, stackTrace) {
      stopwatch.stop();
      _logger.e('Failed to create haiku', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  @override
  HaikuModel fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    if (data == null) {
      throw Exception('Document data is null for haiku ${snapshot.id}');
    }

    // IDをデータに追加してモデルを生成
    return HaikuModel.fromJson({...data, 'id': snapshot.id});
  }

  @override
  Map<String, dynamic> toFirestore(HaikuModel data) {
    final json = data.toJson();

    // Firestoreに保存する際はIDを除外
    // (IDはドキュメントIDとして自動設定される)
    json.remove('id');

    return json;
  }
}
