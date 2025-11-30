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

part 'image_save_state.freezed.dart';

/// 画像保存状態
///
/// Firebase Storageへの画像保存処理の状態を表現する。
/// 初期状態、保存中、成功、エラーの4つの状態を持つ。
///
/// 使用例:
/// ```dart
/// final state = ImageSaveState.saving();
/// state.when(
///   initial: () => print('初期状態'),
///   saving: () => print('保存中...'),
///   success: (url) => print('保存成功: $url'),
///   error: (message) => print('エラー: $message'),
/// );
/// ```
@freezed
class ImageSaveState with _$ImageSaveState {
  /// 初期状態
  ///
  /// 画像保存がまだ開始されていない状態。
  const factory ImageSaveState.initial() = ImageSaveInitial;

  /// 保存中状態
  ///
  /// 画像がFirebase Storageにアップロード中の状態。
  const factory ImageSaveState.saving() = ImageSaveSaving;

  /// 保存成功状態
  ///
  /// 画像保存が成功した状態。
  /// [downloadUrl] アップロードされた画像のダウンロードURL
  const factory ImageSaveState.success(String downloadUrl) = ImageSaveSuccess;

  /// エラー状態
  ///
  /// 画像保存に失敗した状態。
  /// [message] エラーメッセージ
  const factory ImageSaveState.error(String message) = ImageSaveError;
}
