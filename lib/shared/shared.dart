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

/// 共通コンポーネントをエクスポートするライブラリ。
///
/// アプリケーション全体で使用する共通 UI コンポーネントを
/// 一括でインポートできるようにする。
library;

// Constants
export 'constants/app_colors.dart';

// Buttons
export 'widgets/buttons/app_fab_button.dart';
export 'widgets/buttons/app_filled_button.dart';
export 'widgets/buttons/app_outlined_button.dart';

// Layout
export 'widgets/layout/app_body.dart';
export 'widgets/layout/app_scaffold_with_background.dart';
export 'widgets/layout/app_sliver_header.dart';

// Dialogs
export 'widgets/dialogs/app_confirm_dialog.dart';
