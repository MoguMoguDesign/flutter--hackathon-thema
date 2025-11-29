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
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

/// Firebase サービスへのアクセスを提供するユーティリティクラス
///
/// Firestore と Storage のインスタンスへの統一的なアクセスポイントを提供する。
/// 各サービスのインスタンスはシングルトンとして管理される。
///
/// 使用例:
/// ```dart
/// final firestore = FirebaseService.firestore;
/// final storage = FirebaseService.storage;
/// ```
class FirebaseService {
  /// プライベートコンストラクタ（インスタンス化を防ぐ）
  FirebaseService._();

  /// テスト用の Firestore インスタンス
  @visibleForTesting
  static FirebaseFirestore? testFirestore;

  /// テスト用の Storage インスタンス
  @visibleForTesting
  static FirebaseStorage? testStorage;

  /// Cloud Firestore インスタンス
  ///
  /// データベース操作に使用する。
  /// 本番環境とテスト環境で自動的に適切なインスタンスが返される。
  static FirebaseFirestore get firestore =>
      testFirestore ?? FirebaseFirestore.instance;

  /// Firebase Storage インスタンス
  ///
  /// ファイルアップロード・ダウンロード操作に使用する。
  /// 本番環境とテスト環境で自動的に適切なインスタンスが返される。
  static FirebaseStorage get storage => testStorage ?? FirebaseStorage.instance;

  /// テスト用のインスタンスをリセット
  @visibleForTesting
  static void resetForTesting() {
    testFirestore = null;
    testStorage = null;
  }
}
