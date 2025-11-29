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

import 'package:flutter/material.dart';

/// 3ステップインジケーターコンポーネント。
///
/// 俳句入力の進捗（上の句・中の句・下の句）を表示する。
/// ワイヤーフレームの「手順」インジケーターを再現。
class StepIndicator extends StatelessWidget {
  /// ステップインジケーターを作成する。
  ///
  /// [currentStep] は現在のステップ（0, 1, 2）。
  /// [totalSteps] は総ステップ数。デフォルトは3。
  const StepIndicator({
    required this.currentStep,
    this.totalSteps = 3,
    super.key,
  });

  /// 現在のステップ（0始まり）
  final int currentStep;

  /// 総ステップ数
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('手順', style: TextStyle(fontSize: 12, color: Colors.black54)),
        const SizedBox(width: 12),
        ...List.generate(totalSteps, (index) {
          final isActive = index == currentStep;
          final isCompleted = index < currentStep;

          return Row(
            children: [
              Container(
                width: isActive ? 16 : 12,
                height: isActive ? 16 : 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isActive || isCompleted
                      ? Colors.black
                      : Colors.grey.shade300,
                ),
              ),
              if (index < totalSteps - 1)
                Container(
                  width: 40,
                  height: 2,
                  color: isCompleted ? Colors.black : Colors.grey.shade300,
                ),
            ],
          );
        }),
      ],
    );
  }
}
