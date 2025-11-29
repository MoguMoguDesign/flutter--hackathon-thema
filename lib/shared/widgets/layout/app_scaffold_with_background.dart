import 'package:flutter/material.dart';

/// 背景色と背景画像を含む統一されたScaffold。
///
/// アプリケーション全体で共通の背景デザインを提供する。
/// 背景色と背景画像をStackで組み合わせ、その上にコンテンツを表示する。
class AppScaffoldWithBackground extends StatelessWidget {
  /// [AppScaffoldWithBackground] のコンストラクタ。
  ///
  /// [body] は必須パラメータ。
  const AppScaffoldWithBackground({
    required this.body,
    super.key,
    this.backgroundImage = 'assets/images/background.png',
    this.floatingActionButton,
  });

  /// Scaffold内に表示する子ウィジェット。
  final Widget body;

  /// 背景画像のパス。
  ///
  /// デフォルトは 'assets/images/background.png'。
  /// スタート画面などで異なる背景を使用する場合は変更可能。
  final String backgroundImage;

  /// Floating Action Button（オプション）。
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 背景色
          Container(color: const Color(0xFF040811)),
          // PNG背景画像
          Positioned.fill(
            child: Image.asset(
              backgroundImage,
              fit: BoxFit.cover,
              alignment: Alignment.bottomCenter,
            ),
          ),
          // コンテンツ
          body,
        ],
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
