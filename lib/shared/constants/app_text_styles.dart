import 'package:flutter/material.dart';
import 'package:flutterhackthema/shared/constants/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

/// アプリケーション全体で使用するテキストスタイルを定義する。
///
/// TCGマッチマネージャーアプリで一貫したタイポグラフィを提供するため、
/// ヘッドライン、ラベル、ボディテキストのスタイルを統一的に管理する。
class AppTextStyles {
  /// アプリケーション全体で使用するフォントファミリー。
  static String get fontFamily => GoogleFonts.mPlus1p().fontFamily!;

  /// 大見出し用のテキストスタイル。
  /// 主要なタイトルやページヘッダーで使用される。
  /// 20/Auto サイズ。
  static TextStyle get headlineLarge => GoogleFonts.mPlus1p(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: AppColors.userPrimary,
        letterSpacing: -0.28,
      );

  /// 大きなラベル用のテキストスタイル。
  /// セクションヘッダーや重要なラベルで使用される。
  /// 16/24 サイズ。
  static TextStyle get labelLarge => GoogleFonts.mPlus1p(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        height: 1.5, // 24px / 16px
        color: AppColors.textBlack,
      );

  /// 中サイズのラベル用のテキストスタイル。
  /// ボタンや小見出しで使用される。
  /// 14/Auto サイズ。
  static TextStyle get labelMedium => GoogleFonts.mPlus1p(
        fontWeight: FontWeight.bold,
        fontSize: 14,
        color: AppColors.white,
        letterSpacing: -0.28,
      );

  /// 小さなラベル用のテキストスタイル。
  /// バッジやタグ、補助的な情報で使用される。
  /// 10/Auto サイズ。
  static TextStyle get labelSmall => GoogleFonts.mPlus1p(
        fontWeight: FontWeight.bold,
        fontSize: 10,
        color: AppColors.userPrimary,
        letterSpacing: -0.28,
      );

  /// 中サイズの本文テキストスタイル。
  /// 通常の説明文やコンテンツで使用される。
  /// 16/Auto サイズ。
  static TextStyle get bodyMedium => GoogleFonts.mPlus1p(
        fontWeight: FontWeight.normal,
        fontSize: 16,
        color: AppColors.white,
        letterSpacing: -0.28,
      );

  /// 小さな本文テキストスタイル。
  /// 補助的な情報や詳細データで使用される。
  /// 12/Auto サイズ。
  static TextStyle get bodySmall => GoogleFonts.mPlus1p(
        fontWeight: FontWeight.normal,
        fontSize: 12,
        color: AppColors.white,
        letterSpacing: -0.28,
      );
}
