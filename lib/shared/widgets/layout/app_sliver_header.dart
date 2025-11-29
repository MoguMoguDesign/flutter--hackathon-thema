import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// アプリ共通のSliverAppBarヘッダー。
///
/// スクロール時に消える透明な背景のヘッダー。
/// サービスロゴを左揃えで表示する。
class AppSliverHeader extends StatelessWidget {
  /// SliverAppBarヘッダーを作成する。
  const AppSliverHeader({
    super.key,
    this.actions,
  });

  /// 右上に表示するアクションボタン。
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: SvgPicture.asset(
        'assets/images/logo.svg',
        height: 32,
        fit: BoxFit.contain,
      ),
      centerTitle: false, // 左揃え
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
      elevation: 0,
      floating: true,
      snap: true,
      automaticallyImplyLeading: false,
      actions: actions,
    );
  }
}
