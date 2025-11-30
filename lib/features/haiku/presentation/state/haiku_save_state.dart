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

import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutterhackthema/features/haiku/data/models/haiku_model.dart';

part 'haiku_save_state.freezed.dart';

/// 俳句保存の状態を表すクラス
///
/// ローカルキャッシュとFirebase保存の状態を管理します。
@freezed
class HaikuSaveState with _$HaikuSaveState {
  /// 初期状態
  ///
  /// 何も保存されていない状態
  const factory HaikuSaveState.initial() = _Initial;

  /// ローカルキャッシュ保存中
  ///
  /// 画像をローカルファイルシステムに保存中
  const factory HaikuSaveState.savingToCache({required HaikuModel haiku}) =
      _SavingToCache;

  /// ローカルキャッシュ保存完了
  ///
  /// ローカルに保存済み、Firebaseへのアップロード待機中
  const factory HaikuSaveState.cachedLocally({
    required HaikuModel haiku,
    required String localImagePath,
  }) = _CachedLocally;

  /// Firebase保存中
  ///
  /// FirestoreとStorageへのアップロード実行中
  const factory HaikuSaveState.savingToFirebase({
    required HaikuModel haiku,
    required String localImagePath,
  }) = _SavingToFirebase;

  /// 保存完了
  ///
  /// ローカルとFirebase両方に保存が完了した状態
  const factory HaikuSaveState.saved({
    required HaikuModel haiku,
    required String localImagePath,
    required String firebaseImageUrl,
  }) = _Saved;

  /// エラー発生
  ///
  /// 保存処理中にエラーが発生した状態
  const factory HaikuSaveState.error({
    required String message,
    HaikuModel? haiku,
    String? localImagePath,
  }) = _Error;
}

/// HaikuSaveStateの拡張メソッド
extension HaikuSaveStateExtension on HaikuSaveState {
  /// ローカルに保存済みかどうか
  bool get isCached => maybeWhen(
    cachedLocally: (haiku, localPath) => true,
    savingToFirebase: (haiku, localPath) => true,
    saved: (haiku, localPath, firebasePath) => true,
    orElse: () => false,
  );

  /// Firebase保存完了かどうか
  bool get isSaved => maybeWhen(
    saved: (haiku, localPath, firebasePath) => true,
    orElse: () => false,
  );

  /// エラー状態かどうか
  bool get isError => maybeWhen(
    error: (message, haiku, localPath) => true,
    orElse: () => false,
  );

  /// 処理中かどうか
  bool get isProcessing => maybeWhen(
    savingToCache: (haiku) => true,
    savingToFirebase: (haiku, localPath) => true,
    orElse: () => false,
  );

  /// 俳句データを取得
  HaikuModel? get haiku => maybeWhen(
    savingToCache: (haiku) => haiku,
    cachedLocally: (haiku, localPath) => haiku,
    savingToFirebase: (haiku, localPath) => haiku,
    saved: (haiku, localPath, firebasePath) => haiku,
    error: (message, haiku, localPath) => haiku,
    orElse: () => null,
  );

  /// ローカル画像パスを取得
  String? get localImagePath => maybeWhen(
    cachedLocally: (haiku, path) => path,
    savingToFirebase: (haiku, path) => path,
    saved: (haiku, path, firebasePath) => path,
    error: (message, haiku, path) => path,
    orElse: () => null,
  );
}
