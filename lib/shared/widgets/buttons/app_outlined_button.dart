import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';

/// アプリケーション全体で使用する統一された Outlined Button。
///
/// Material Design の OutlinedButton をベースに、
/// アプリのデザインシステムに準拠したスタイルを適用する。
/// オプションで leading アイコンを表示できる。
class AppOutlinedButton extends StatelessWidget {
  /// [AppOutlinedButton] のコンストラクタ。
  ///
  /// [onPressed] と [label] は必須パラメータ。
  const AppOutlinedButton({
    required this.onPressed,
    required this.label,
    super.key,
    this.leadingIcon,
    this.isLoading = false,
    this.borderColor,
    this.foregroundColor,
    this.width,
    this.height = 56.0,
    this.textStyle,
  });

  /// ボタンが押されたときのコールバック。
  ///
  /// null の場合、ボタンは無効状態になる。
  final VoidCallback? onPressed;

  /// ボタンに表示するテキスト。
  final String label;

  /// ボタンの先頭に表示するアイコン（オプション）。
  final IconData? leadingIcon;

  /// ローディング状態を示すフラグ。
  ///
  /// true の場合、ボタンはローディングインジケーターを表示し、
  /// タップを無効にする。
  final bool isLoading;

  /// ボタンの境界線の色（オプション）。
  ///
  /// 指定しない場合、デフォルトは [AppColors.textBlack]。
  final Color? borderColor;

  /// ボタンの前景色（オプション）。
  ///
  /// 指定しない場合、デフォルトは [AppColors.textBlack]。
  final Color? foregroundColor;

  /// ボタンの幅（オプション）。
  ///
  /// 指定しない場合、コンテンツに応じて自動調整される。
  final double? width;

  /// ボタンの高さ。
  ///
  /// デフォルトは 56.0。
  final double height;

  /// カスタムテキストスタイル（オプション）。
  ///
  /// 指定しない場合、デフォルトは [AppTextStyles.labelMedium]。
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final Color bColor = borderColor ?? AppColors.textBlack;
    final Color fgColor = foregroundColor ?? AppColors.textBlack;

    final Widget content = isLoading
        ? SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(fgColor),
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (leadingIcon != null) ...<Widget>[
                Icon(leadingIcon, size: 20, color: fgColor),
                const SizedBox(width: 8),
              ],
              Flexible(
                child: Text(
                  label,
                  style: textStyle != null
                      ? textStyle!.copyWith(color: fgColor)
                      : AppTextStyles.labelMedium.copyWith(color: fgColor),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          );

    final ButtonStyle buttonStyle =
        OutlinedButton.styleFrom(
          backgroundColor: AppColors.white,
          foregroundColor: fgColor,
          disabledBackgroundColor: AppColors.white,
          disabledForegroundColor: AppColors.textDisabled,
          minimumSize: Size(width ?? 0, height),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          side: BorderSide(
            color: onPressed == null ? AppColors.borderDisabled : bColor,
            width: 3.0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(height / 2),
          ),
        ).copyWith(
          overlayColor: WidgetStateProperty.all(
            const Color(0xFF2C0305).withOpacity(0.2),
          ),
        );

    final Widget button = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(height / 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: buttonStyle,
        child: content,
      ),
    );

    if (width != null) {
      return SizedBox(width: width, height: height, child: button);
    }

    return SizedBox(height: height, child: button);
  }
}
