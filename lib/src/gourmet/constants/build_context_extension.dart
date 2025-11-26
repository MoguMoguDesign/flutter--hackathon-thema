import 'package:flutter/material.dart';

/// BuildContext の拡張メソッド。
extension BuildContextExtension on BuildContext {
  /// テーマのテキストスタイルを取得する。
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// テーマのカラースキームを取得する。
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
}
