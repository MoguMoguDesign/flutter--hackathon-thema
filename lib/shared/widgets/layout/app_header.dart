import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';

/// アプリケーション全体で使用する統一されたヘッダーコンポーネント。
///
/// 画面上部に表示されるヘッダーで、タイトルと
/// オプションでアクションボタンや戻るボタンを表示できる。
class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  /// [AppHeader] のコンストラクタ。
  ///
  /// [title] は必須パラメータ。
  const AppHeader({
    required this.title,
    super.key,
    this.showBackButton = true,
    this.actions,
    this.backgroundColor,
    this.foregroundColor,
    this.centerTitle = true,
    this.elevation = 0,
  });

  /// ヘッダーに表示するタイトル。
  final String title;

  /// 戻るボタンを表示するかどうか。
  ///
  /// デフォルトは true。
  final bool showBackButton;

  /// ヘッダー右側に表示するアクションボタンのリスト。
  final List<Widget>? actions;

  /// ヘッダーの背景色（オプション）。
  ///
  /// 指定しない場合、デフォルトは透明。
  final Color? backgroundColor;

  /// ヘッダーの前景色（オプション）。
  ///
  /// 指定しない場合、デフォルトは [AppColors.white]。
  final Color? foregroundColor;

  /// タイトルを中央揃えにするかどうか。
  ///
  /// デフォルトは true。
  final bool centerTitle;

  /// ヘッダーの影の高さ。
  ///
  /// デフォルトは 0（影なし）。
  final double elevation;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final Color fgColor = foregroundColor ?? AppColors.white;

    return AppBar(
      title: Text(
        title,
        style: AppTextStyles.labelLarge.copyWith(color: fgColor),
      ),
      centerTitle: centerTitle,
      backgroundColor: backgroundColor ?? Colors.transparent,
      foregroundColor: fgColor,
      elevation: elevation,
      automaticallyImplyLeading: showBackButton,
      leading: showBackButton && Navigator.of(context).canPop()
          ? IconButton(
              icon: Icon(Icons.arrow_back, color: fgColor),
              onPressed: () => Navigator.of(context).pop(),
            )
          : null,
      actions: actions,
    );
  }
}
