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

/// 俳句の保存状態を表すEnum
///
/// ローカルキャッシュとFirebaseへの保存状態を管理します。
enum SaveStatus {
  /// ローカルキャッシュのみに保存済み（Firebaseへの保存待ち）
  localOnly,

  /// Firebaseへの保存処理中
  saving,

  /// Firebaseへの保存完了
  saved,

  /// Firebaseへの保存失敗（リトライ待ち）
  failed,
}

/// SaveStatusの拡張機能
extension SaveStatusExtension on SaveStatus {
  /// 保存状態が完了しているかどうか
  bool get isSaved => this == SaveStatus.saved;

  /// 保存状態が進行中かどうか
  bool get isSaving => this == SaveStatus.saving;

  /// 保存状態が失敗しているかどうか
  bool get isFailed => this == SaveStatus.failed;

  /// ローカルのみに保存されているかどうか
  bool get isLocalOnly => this == SaveStatus.localOnly;

  /// 保存が必要かどうか（savedでない状態）
  bool get needsSave => this != SaveStatus.saved;

  /// 表示用のテキストを取得
  String get displayText {
    switch (this) {
      case SaveStatus.localOnly:
        return '保存待ち';
      case SaveStatus.saving:
        return '保存中';
      case SaveStatus.saved:
        return '保存完了';
      case SaveStatus.failed:
        return '保存失敗';
    }
  }
}
