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

import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';

import 'package:flutterhackthema/shared/data/repositories/storage_repository.dart';

/// 俳句画像のFirebase Storageリポジトリ
///
/// 生成された俳句画像をFirebase Storageに保存・取得する機能を提供する。
/// [StorageRepository]を継承し、俳句画像専用のストレージ操作を実装する。
///
/// 使用例:
/// ```dart
/// final repository = HaikuImageStorageRepository();
/// final downloadUrl = await repository.uploadHaikuImage(
///   imageData: imageBytes,
///   haikuId: 'haiku123',
///   metadata: HaikuImageMetadata(
///     firstLine: '古池や',
///     secondLine: '蛙飛び込む',
///     thirdLine: '水の音',
///   ),
/// );
/// ```
class HaikuImageStorageRepository extends StorageRepository {
  /// コンストラクタ
  HaikuImageStorageRepository() : super(basePath: 'haiku_images');

  final Logger _logger = Logger();
  final Uuid _uuid = const Uuid();

  /// 俳句画像をアップロードする
  ///
  /// [imageData] 画像のバイナリデータ
  /// [haikuId] 俳句のID(オプション、未指定時はUUID生成)
  /// [userId] ユーザーID(オプション、'anonymous'がデフォルト)
  /// [metadata] 画像メタデータ(俳句内容など)
  ///
  /// Returns: アップロードされた画像のダウンロードURL
  Future<String> uploadHaikuImage({
    required Uint8List imageData,
    String? haikuId,
    String? userId,
    HaikuImageMetadata? metadata,
  }) async {
    final stopwatch = Stopwatch()..start();
    final effectiveHaikuId = haikuId ?? _uuid.v4();
    final effectiveUserId = userId ?? 'anonymous';
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final fileName = '$effectiveUserId/${effectiveHaikuId}_$timestamp.jpg';

    try {
      _logger.i('Uploading haiku image: $fileName');

      final settableMetadata = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: metadata?.toMap(),
      );

      final downloadUrl = await upload(
        fileName,
        imageData,
        metadata: settableMetadata,
      );

      stopwatch.stop();
      _logger.i(
        'Haiku image uploaded successfully: $fileName '
        '(${stopwatch.elapsedMilliseconds}ms)',
      );

      return downloadUrl;
    } catch (e, stackTrace) {
      stopwatch.stop();
      _logger.e(
        'Failed to upload haiku image: $fileName',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}

/// 俳句画像のメタデータ
///
/// Firebase Storageに保存する際のカスタムメタデータを定義する。
class HaikuImageMetadata {
  /// コンストラクタ
  const HaikuImageMetadata({
    this.firstLine,
    this.secondLine,
    this.thirdLine,
    this.createdAt,
  });

  /// 上の句
  final String? firstLine;

  /// 中の句
  final String? secondLine;

  /// 下の句
  final String? thirdLine;

  /// 作成日時
  final DateTime? createdAt;

  /// Mapに変換
  Map<String, String>? toMap() {
    final Map<String, String> map = {};
    if (firstLine != null) map['firstLine'] = firstLine!;
    if (secondLine != null) map['secondLine'] = secondLine!;
    if (thirdLine != null) map['thirdLine'] = thirdLine!;
    if (createdAt != null) map['createdAt'] = createdAt!.toIso8601String();
    return map.isEmpty ? null : map;
  }
}
