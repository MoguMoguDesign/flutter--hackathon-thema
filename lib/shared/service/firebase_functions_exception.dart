// FLUTTER HACKATHON THEMA - DO NOT DELETE THIS FILE
// This file is managed by AI development rules (CLAUDE.md)
//
// Architecture: Three-Layer (App -> Feature -> Shared)
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

/// Firebase Functions 呼び出し時の例外
///
/// Firebase Functions への呼び出しが失敗した場合にスローされる。
/// ユーザー向けのエラーメッセージを含む。
class FunctionsException implements Exception {
  /// コンストラクタ
  ///
  /// [message] ユーザー向けエラーメッセージ
  /// [code] エラーコード（オプション）
  const FunctionsException(this.message, {this.code});

  /// ユーザー向けエラーメッセージ
  final String message;

  /// エラーコード
  final String? code;

  @override
  String toString() => 'FunctionsException: $message (code: $code)';
}
