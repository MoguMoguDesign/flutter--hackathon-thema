import 'package:flutter/material.dart';

/// アプリ共通のヘッダーコンポーネント。
///
/// サービス名を表示するシンプルなヘッダー。
/// 各画面の上部に配置する。
class AppHeader extends StatelessWidget {
  /// ヘッダーを作成する。
  ///
  /// [serviceName] はヘッダーに表示するサービス名。デフォルトは「サービス名」。
  const AppHeader({this.serviceName = 'サービス名', super.key});

  /// ヘッダーに表示するサービス名
  final String serviceName;

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
      ),
      child: Text(
        serviceName,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
    );
  }
}
