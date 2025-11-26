import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

/// ダイアログ内で使用するボタン群を提供するウィジェット。
///
/// Figma の DialogButtons（node-id: 86-7843）に準拠し、
/// ダイアログ内のアクションボタンレイアウトを統一的に管理する。
class DialogButtons extends StatelessWidget {
  /// [DialogButtons] のコンストラクタ。
  ///
  /// [primaryText] が null の場合、プライマリボタンは表示されない。
  /// [onPrimaryPressed] が null の場合、プライマリボタンは無効化される。
  /// [secondaryText] が null の場合、セカンダリボタンは表示されない。
  /// [onSecondaryPressed] が null の場合、セカンダリボタンは無効化される。
  const DialogButtons({
    super.key,
    this.primaryText,
    this.onPrimaryPressed,
    this.secondaryText,
    this.onSecondaryPressed,
    this.isVertical = false,
    this.primaryStyle = DialogButtonStyle.primary,
  });

  /// プライマリボタンのテキスト。
  /// null の場合、プライマリボタンは表示されない。
  final String? primaryText;

  /// プライマリボタンタップ時のコールバック。
  /// null の場合、ボタンは無効化される。
  final VoidCallback? onPrimaryPressed;

  /// セカンダリボタンのテキスト。
  /// null の場合はセカンダリボタンを表示しない。
  final String? secondaryText;

  /// セカンダリボタンタップ時のコールバック。
  final VoidCallback? onSecondaryPressed;

  /// ボタンを縦方向に配置するかどうか。
  /// false の場合は横方向に配置される。
  final bool isVertical;

  /// プライマリボタンのスタイル。
  final DialogButtonStyle primaryStyle;

  @override
  Widget build(BuildContext context) {
    final hasPrimaryButton = primaryText != null;
    final hasSecondaryButton = secondaryText != null;

    // 両方のボタンがない場合は空のウィジェットを返す。
    if (!hasPrimaryButton && !hasSecondaryButton) {
      return const SizedBox.shrink();
    }

    if (isVertical) {
      return Column(
        children: [
          if (hasSecondaryButton) ...[
            _DialogActionButton(
              text: secondaryText!,
              style: DialogButtonStyle.secondary,
              onPressed: onSecondaryPressed,
            ),
            if (hasPrimaryButton) const SizedBox(height: 12),
          ],
          if (hasPrimaryButton)
            _DialogActionButton(
              text: primaryText!,
              style: primaryStyle,
              onPressed: onPrimaryPressed,
            ),
        ],
      );
    }

    return Row(
      children: [
        if (hasSecondaryButton) ...[
          Expanded(
            child: _DialogActionButton(
              text: secondaryText!,
              style: DialogButtonStyle.secondary,
              onPressed: onSecondaryPressed,
            ),
          ),
          if (hasPrimaryButton) const SizedBox(width: 12),
        ],
        if (hasPrimaryButton)
          Expanded(
            child: _DialogActionButton(
              text: primaryText!,
              style: primaryStyle,
              onPressed: onPrimaryPressed,
            ),
          ),
      ],
    );
  }
}

/// ダイアログボタンの内部実装ウィジェット。
class _DialogActionButton extends StatelessWidget {
  const _DialogActionButton({
    required this.text,
    required this.style,
    this.onPressed,
  });

  /// ボタンのテキスト。
  final String text;

  /// ボタンのスタイル。
  final DialogButtonStyle style;

  /// ボタンタップ時のコールバック。
  /// null の場合、ボタンは無効化される。
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final isEnabled = onPressed != null;
    final colors = _getStyleColors(style);

    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: isEnabled ? colors.backgroundColor : AppColors.borderDisabled,
        borderRadius: BorderRadius.circular(22),
        boxShadow: isEnabled ? colors.boxShadow : null,
      ),
      child: Material(
        color: AppColors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(22),
          child: Center(
            child: Text(
              text,
              style: AppTextStyles.labelMedium.copyWith(
                color: isEnabled ? colors.textColor : AppColors.textDisabled,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _DialogButtonColors _getStyleColors(DialogButtonStyle style) {
    switch (style) {
      case DialogButtonStyle.primary:
        return _DialogButtonColors(
          backgroundColor: AppColors.userPrimary,
          textColor: AppColors.textBlack,
          boxShadow: [
            BoxShadow(
              color: AppColors.userPrimary.withValues(alpha: 0.5),
              blurRadius: 20,
            ),
          ],
        );
      case DialogButtonStyle.secondary:
        return const _DialogButtonColors(
          backgroundColor: AppColors.transparent,
          textColor: AppColors.gray,
        );
      case DialogButtonStyle.admin:
        return _DialogButtonColors(
          backgroundColor: AppColors.adminPrimary,
          textColor: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.adminPrimary.withValues(alpha: 0.1),
              blurRadius: 20,
            ),
          ],
        );
      case DialogButtonStyle.alert:
        return const _DialogButtonColors(
          backgroundColor: AppColors.alart,
          textColor: AppColors.white,
        );
    }
  }
}

/// ダイアログボタンのスタイルを表す列挙型。
enum DialogButtonStyle {
  /// プライマリボタンのスタイル（塗りつぶし）。
  primary,

  /// セカンダリボタンのスタイル（アウトライン）。
  secondary,

  /// 管理者向けボタンのスタイル（青色塗りつぶし）。
  admin,

  /// アラートボタンのスタイル（赤色塗りつぶし）。
  alert,
}

/// ダイアログボタンの色情報を保持するクラス。
class _DialogButtonColors {
  const _DialogButtonColors({
    required this.backgroundColor,
    required this.textColor,
    this.boxShadow,
  });

  /// 背景色。
  final Color backgroundColor;

  /// テキスト色。
  final Color textColor;

  /// ボックスシャドウ。不要な場合は null。
  final List<BoxShadow>? boxShadow;
}
