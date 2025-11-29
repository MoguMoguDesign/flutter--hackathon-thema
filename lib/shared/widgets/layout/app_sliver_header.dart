import 'package:flutter/material.dart';

/// アプリ共通のSliverAppBarヘッダー。
///
/// スクロール時に消える透明な背景のヘッダー。
/// サービス名を左揃えで表示する。
class AppSliverHeader extends StatelessWidget {
  /// SliverAppBarヘッダーを作成する。
  ///
  /// [serviceName] はヘッダーに表示するサービス名。
  const AppSliverHeader({this.serviceName = 'サービス名', super.key});

  /// ヘッダーに表示するサービス名
  final String serviceName;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text(serviceName),
      centerTitle: false, // 左揃え
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.black,
      elevation: 0,
      floating: true,
      snap: true,
      automaticallyImplyLeading: false,
    );
  }
}
