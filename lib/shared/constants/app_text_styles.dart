import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// アプリケーション全体で使用するテキストスタイルを定義する。
///
/// TCGマッチマネージャーアプリで一貫したタイポグラフィを提供するため、
/// ヘッドライン、ラベル、ボディテキストのスタイルを統一的に管理する。
class AppTextStyles {
  /// アプリケーション全体で使用するフォントファミリー。
  static String get fontFamily => GoogleFonts.rocknRollOne().fontFamily!;

  /// 大見出し用のテキストスタイル。
  /// 主要なタイトルやページヘッダーで使用される。
  /// 20/Auto サイズ。
  static TextStyle get headlineLarge => GoogleFonts.rocknRollOne(
    fontWeight: FontWeight.normal,
    fontSize: 20,
    color: AppColors.userPrimary,
    letterSpacing: 1.2,
    height: 1.4,
  );

  /// 大きなラベル用のテキストスタイル。
  /// セクションヘッダーや重要なラベルで使用される。
  /// 16/24 サイズ。
  static TextStyle get labelLarge => GoogleFonts.rocknRollOne(
    fontWeight: FontWeight.normal,
    fontSize: 16,
    height: 1.6, // 24px / 16px
    color: AppColors.textBlack,
    letterSpacing: 1.0,
  );

  /// 中サイズのラベル用のテキストスタイル。
  /// ボタンや小見出しで使用される。
  /// 18/Auto サイズ。
  static TextStyle get labelMedium => GoogleFonts.rocknRollOne(
    fontWeight: FontWeight.normal,
    fontSize: 18,
    color: AppColors.white,
    letterSpacing: 1.0,
    height: 1.3,
  );

  /// 小さなラベル用のテキストスタイル。
  /// バッジやタグ、補助的な情報で使用される。
  /// 10/Auto サイズ。
  static TextStyle get labelSmall => GoogleFonts.rocknRollOne(
    fontWeight: FontWeight.normal,
    fontSize: 10,
    color: AppColors.userPrimary,
    letterSpacing: 0.8,
    height: 1.4,
  );

  /// 中サイズの本文テキストスタイル。
  /// 通常の説明文やコンテンツで使用される。
  /// 16/Auto サイズ。
  static TextStyle get bodyMedium => GoogleFonts.rocknRollOne(
    fontWeight: FontWeight.normal,
    fontSize: 16,
    color: AppColors.white,
    letterSpacing: 0.8,
    height: 1.5,
  );

  /// 小さな本文テキストスタイル。
  /// 補助的な情報や詳細データで使用される。
  /// 12/Auto サイズ。
  static TextStyle get bodySmall => GoogleFonts.rocknRollOne(
    fontWeight: FontWeight.normal,
    fontSize: 12,
    color: AppColors.white,
    letterSpacing: 0.6,
    height: 1.5,
  );
}
