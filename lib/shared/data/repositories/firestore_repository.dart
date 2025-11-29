// FLUTTER HACKATHON THEMA - DO NOT DELETE THIS FILE
// This file is managed by AI development rules (CLAUDE.md)
//
// Architecture: Three-Layer (App → Feature → Shared)
// State Management: hooks_riverpod 3.x with @riverpod annotation (MANDATORY)
// Router: go_router 16.x (MANDATORY)
// Code Generation: build_runner, riverpod_generator, freezed (REQUIRED)
// Testing: Comprehensive coverage required
//
// Development Rules:
// - Use @riverpod annotation for all providers
// - Use HookConsumerWidget when using hooks
// - Documentation comments in Japanese (///)
// - Follow three-layer architecture strictly
// - No direct Feature-to-Feature dependencies
// - All changes must pass: analyze, format, test
//

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'package:flutterhackthema/shared/service/firebase_service.dart';

/// Firestore リポジトリの基底クラス
///
/// CRUD 操作の共通インターフェースを提供する。
/// 各機能層のリポジトリはこのクラスを継承して実装する。
///
/// 型パラメータ:
/// - [T]: データモデルの型（Freezed モデルなど）
///
/// 使用例:
/// ```dart
/// class UserRepository extends FirestoreRepository<User> {
///   UserRepository() : super(collectionPath: 'users');
///
///   @override
///   User fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
///     return User.fromJson(snapshot.data()!);
///   }
///
///   @override
///   Map<String, dynamic> toFirestore(User data) {
///     return data.toJson();
///   }
/// }
/// ```
abstract class FirestoreRepository<T> {
  /// コンストラクタ
  ///
  /// [collectionPath]: Firestore コレクションのパス
  FirestoreRepository({required this.collectionPath});

  /// Firestore コレクションのパス
  final String collectionPath;

  /// Firestore インスタンス
  ///
  /// テスト時にオーバーライド可能にするため protected として公開
  @protected
  FirebaseFirestore get firestore => FirebaseService.firestore;

  /// コレクション参照
  CollectionReference<Map<String, dynamic>> get collection =>
      firestore.collection(collectionPath);

  /// Firestore ドキュメントからモデルに変換
  ///
  /// サブクラスで実装が必要。
  T fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot);

  /// モデルから Firestore ドキュメントに変換
  ///
  /// サブクラスで実装が必要。
  Map<String, dynamic> toFirestore(T data);

  /// ドキュメントを作成
  ///
  /// [data]: 作成するデータ
  /// [docId]: ドキュメント ID（省略時は自動生成）
  ///
  /// Returns: 作成されたドキュメントの ID
  Future<String> create(T data, {String? docId}) async {
    final doc = docId != null ? collection.doc(docId) : collection.doc();
    await doc.set(toFirestore(data));
    return doc.id;
  }

  /// ドキュメントを取得
  ///
  /// [docId]: 取得するドキュメントの ID
  ///
  /// Returns: データモデル、存在しない場合は null
  Future<T?> read(String docId) async {
    final snapshot = await collection.doc(docId).get();
    if (!snapshot.exists) return null;
    return fromFirestore(snapshot);
  }

  /// ドキュメントを更新
  ///
  /// [docId]: 更新するドキュメントの ID
  /// [data]: 更新するデータ
  Future<void> update(String docId, T data) async {
    await collection.doc(docId).update(toFirestore(data));
  }

  /// ドキュメントを削除
  ///
  /// [docId]: 削除するドキュメントの ID
  Future<void> delete(String docId) async {
    await collection.doc(docId).delete();
  }

  /// コレクション内の全ドキュメントを取得
  ///
  /// Returns: データモデルのリスト
  Future<List<T>> readAll() async {
    final snapshot = await collection.get();
    return snapshot.docs.map((doc) => fromFirestore(doc)).toList();
  }

  /// クエリ結果をストリームとして取得
  ///
  /// [query]: Firestore クエリ（省略時は全ドキュメント）
  ///
  /// Returns: データモデルのストリーム
  Stream<List<T>> watchAll({Query<Map<String, dynamic>>? query}) {
    final targetQuery = query ?? collection;
    return targetQuery.snapshots().map(
      (snapshot) => snapshot.docs
          .map(
            (doc) =>
                fromFirestore(doc as DocumentSnapshot<Map<String, dynamic>>),
          )
          .toList(),
    );
  }

  /// 特定のドキュメントをストリームとして監視
  ///
  /// [docId]: 監視するドキュメントの ID
  ///
  /// Returns: データモデルのストリーム（存在しない場合は null）
  Stream<T?> watch(String docId) {
    return collection.doc(docId).snapshots().map((snapshot) {
      if (!snapshot.exists) return null;
      return fromFirestore(snapshot);
    });
  }
}
