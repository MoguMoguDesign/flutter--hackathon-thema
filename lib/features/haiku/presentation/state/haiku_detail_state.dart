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

import '../../data/models/haiku_model.dart';

part 'haiku_detail_state.freezed.dart';

/// 俳句詳細画面の状態
///
/// Freezedを使用して不変な状態クラスを定義します。
/// 初期状態、ローディング、データ読み込み完了、エラーの
/// 4つの状態を持ちます。
@freezed
class HaikuDetailState with _$HaikuDetailState {
  /// 初期状態
  const factory HaikuDetailState.initial() = _Initial;

  /// ローディング中
  const factory HaikuDetailState.loading() = _Loading;

  /// データ読み込み完了
  ///
  /// [haiku] 表示する俳句データ
  /// [nickname] 作者のニックネーム（nullの場合は"匿名"を表示）
  const factory HaikuDetailState.loaded({
    required HaikuModel haiku,
    String? nickname,
  }) = _Loaded;

  /// エラー状態
  ///
  /// [message] エラーメッセージ
  const factory HaikuDetailState.error(String message) = _Error;
}
