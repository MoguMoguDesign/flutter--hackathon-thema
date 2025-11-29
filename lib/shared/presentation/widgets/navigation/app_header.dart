import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// アプリ共通のヘッダーコンポーネント。
///
/// サービスロゴを表示するシンプルなヘッダー。
/// 各画面の上部に配置する。
class AppHeader extends StatelessWidget {
  /// ヘッダーを作成する。
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200, width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SvgPicture.asset(
        'assets/images/logo.svg',
        height: 32,
        fit: BoxFit.contain,
        alignment: Alignment.centerLeft,
      ),
    );
  }
}
