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

import 'package:flutterhackthema/shared/models/image_generation_result.dart';

/// スタブ関数（非Web環境用）
///
/// この関数は実際には呼び出されない。
/// 条件付きインポートでWebではない場合にこのファイルが使用される。
Future<ImageGenerationResult> generateImageWeb({
  required String prompt,
  String aspectRatio = '4:5',
}) {
  throw UnsupportedError('generateImageWeb is only supported on web');
}
