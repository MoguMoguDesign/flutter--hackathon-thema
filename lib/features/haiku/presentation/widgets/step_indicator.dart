import 'package:flutter/material.dart';

import '../../../../shared/constants/app_colors.dart';

/// 4ステップインジケーターコンポーネント。
///
/// 俳句入力の進捗（上の句・中の句・下の句・確認）を表示する。
/// ワイヤーフレームの「手順」インジケーターを再現。
class StepIndicator extends StatelessWidget {
  /// ステップインジケーターを作成する。
  ///
  /// [currentStep] は現在のステップ（0, 1, 2, 3）。
  /// [totalSteps] は総ステップ数。デフォルトは4。
  const StepIndicator({
    required this.currentStep,
    this.totalSteps = 4,
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
        ...List.generate(totalSteps, (index) {
          final isActive = index == currentStep;
          final isCompleted = index < currentStep;

          return Row(
            children: [
              _StepDot(
                isActive: isActive,
                isCompleted: isCompleted,
              ),
              if (index < totalSteps - 1)
                _StepConnector(isCompleted: isCompleted),
            ],
          );
        }),
      ],
    );
  }
}

/// ステップドット
class _StepDot extends StatelessWidget {
  const _StepDot({
    required this.isActive,
    required this.isCompleted,
  });

  final bool isActive;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: isActive ? 20 : 16,
      height: isActive ? 20 : 16,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _getDotColor(),
        border: isActive
            ? Border.all(
                color: AppColors.white,
                width: 2.5,
              )
            : null,
        boxShadow: (isActive || isCompleted)
            ? [
                BoxShadow(
                  color: AppColors.accent.withOpacity(0.4),
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
              ]
            : null,
      ),
    );
  }

  Color _getDotColor() {
    if (isActive || isCompleted) {
      return AppColors.accent;
    } else {
      return AppColors.white.withOpacity(0.25);
    }
  }
}

/// ステップ間の接続線
class _StepConnector extends StatelessWidget {
  const _StepConnector({
    required this.isCompleted,
  });

  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: 32,
      height: 3,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: isCompleted
            ? AppColors.accent
            : AppColors.white.withOpacity(0.25),
        boxShadow: isCompleted
            ? [
                BoxShadow(
                  color: AppColors.accent.withOpacity(0.3),
                  blurRadius: 4,
                  spreadRadius: 0.5,
                ),
              ]
            : null,
      ),
    );
  }
}
