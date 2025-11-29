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

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

import 'package:flutterhackthema/shared/service/firebase_service.dart';

/// Storage リポジトリの基底クラス
///
/// ファイルのアップロード・ダウンロード・削除の共通インターフェースを提供する。
/// 各機能層のストレージリポジトリはこのクラスを継承して実装する。
///
/// 使用例:
/// ```dart
/// class ImageStorageRepository extends StorageRepository {
///   ImageStorageRepository() : super(basePath: 'images');
///
///   Future<String> uploadUserAvatar(String userId, Uint8List imageData) {
///     return upload('avatars/$userId.jpg', imageData);
///   }
/// }
/// ```
abstract class StorageRepository {
  /// コンストラクタ
  ///
  /// [basePath]: Storage のベースパス（例: 'images', 'documents'）
  StorageRepository({required this.basePath});

  /// Storage のベースパス
  final String basePath;

  /// Firebase Storage インスタンス
  ///
  /// テスト時にオーバーライド可能にするため protected として公開
  @protected
  FirebaseStorage get storage => FirebaseService.storage;

  /// ベースパスの参照
  Reference get baseRef => storage.ref(basePath);

  /// ファイルをアップロード
  ///
  /// [fileName]: ファイル名（ベースパスからの相対パス）
  /// [data]: アップロードするバイトデータ
  /// [metadata]: ファイルのメタデータ（省略可）
  ///
  /// Returns: アップロードされたファイルのダウンロード URL
  Future<String> upload(
    String fileName,
    Uint8List data, {
    SettableMetadata? metadata,
  }) async {
    final ref = baseRef.child(fileName);
    await ref.putData(data, metadata);
    return ref.getDownloadURL();
  }

  /// ファイルをダウンロード
  ///
  /// [fileName]: ファイル名（ベースパスからの相対パス）
  ///
  /// Returns: ダウンロードしたバイトデータ
  Future<Uint8List?> download(String fileName) async {
    final ref = baseRef.child(fileName);
    try {
      return await ref.getData();
    } on FirebaseException catch (e) {
      if (e.code == 'object-not-found') {
        return null;
      }
      rethrow;
    }
  }

  /// ファイルを削除
  ///
  /// [fileName]: ファイル名（ベースパスからの相対パス）
  Future<void> delete(String fileName) async {
    final ref = baseRef.child(fileName);
    await ref.delete();
  }

  /// ファイルのダウンロード URL を取得
  ///
  /// [fileName]: ファイル名（ベースパスからの相対パス）
  ///
  /// Returns: ダウンロード URL、存在しない場合は null
  Future<String?> getDownloadUrl(String fileName) async {
    final ref = baseRef.child(fileName);
    try {
      return await ref.getDownloadURL();
    } on FirebaseException catch (e) {
      if (e.code == 'object-not-found') {
        return null;
      }
      rethrow;
    }
  }

  /// ディレクトリ内の全ファイルを一覧取得
  ///
  /// [path]: ディレクトリパス（ベースパスからの相対パス、省略時はルート）
  ///
  /// Returns: ファイル参照のリスト
  Future<List<Reference>> listFiles({String? path}) async {
    final ref = path != null ? baseRef.child(path) : baseRef;
    final result = await ref.listAll();
    return result.items;
  }

  /// ファイルのメタデータを取得
  ///
  /// [fileName]: ファイル名（ベースパスからの相対パス）
  ///
  /// Returns: ファイルのメタデータ、存在しない場合は null
  Future<FullMetadata?> getMetadata(String fileName) async {
    final ref = baseRef.child(fileName);
    try {
      return await ref.getMetadata();
    } on FirebaseException catch (e) {
      if (e.code == 'object-not-found') {
        return null;
      }
      rethrow;
    }
  }
}
