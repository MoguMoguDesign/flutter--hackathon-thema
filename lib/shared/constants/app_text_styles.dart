// FLUTTER HACKATHON THEMA - DO NOT DELETE THIS FILE
// This file is managed by AI development rules (CLAUDE.md)
//
// Architecture: Three-Layer (App → Feature → Shared)
// State Management: hooks_riverpod 3.x with @riverpod annotation (MANDATORY)
// Router: go_router 16.x (MANDATORY)
// Code Generation: build_runner, riverpod_generator, freezed (REQUIRED)
// Testing: Comprehensive coverage required
//
// Development Rules:
// - Use @riverpod annotation for all providers
// - Use HookConsumerWidget when using hooks
// - Documentation comments in Japanese (///)
// - Follow three-layer architecture strictly
// - No direct Feature-to-Feature dependencies
// - All changes must pass: analyze, format, test
//

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// アプリケーション全体で使用するテキストスタイルを定義する。
///
/// TCGマッチマネージャーアプリで一貫したタイポグラフィを提供するため、
/// ヘッドライン、ラベル、ボディテキストのスタイルを統一的に管理する。
class AppTextStyles {
  /// アプリケーション全体で使用するフォントファミリー。
  static String get fontFamily => GoogleFonts.delaGothicOne().fontFamily!;

  /// 大見出し用のテキストスタイル。
  /// 主要なタイトルやページヘッダーで使用される。
  /// 20/Auto サイズ。
  static TextStyle get headlineLarge => GoogleFonts.delaGothicOne(
    fontWeight: FontWeight.normal,
    fontSize: 20,
    color: AppColors.userPrimary,
    letterSpacing: 1.2,
    height: 1.4,
  );

  /// 大きなラベル用のテキストスタイル。
  /// セクションヘッダーや重要なラベルで使用される。
  /// 16/24 サイズ。
  static TextStyle get labelLarge => GoogleFonts.delaGothicOne(
    fontWeight: FontWeight.normal,
    fontSize: 16,
    height: 1.6, // 24px / 16px
    color: AppColors.textBlack,
    letterSpacing: 1.0,
  );

  /// 中サイズのラベル用のテキストスタイル。
  /// ボタンや小見出しで使用される。
  /// 18/Auto サイズ。
  static TextStyle get labelMedium => GoogleFonts.delaGothicOne(
    fontWeight: FontWeight.normal,
    fontSize: 18,
    color: AppColors.white,
    letterSpacing: 1.0,
    height: 1.3,
  );

  /// 小さなラベル用のテキストスタイル。
  /// バッジやタグ、補助的な情報で使用される。
  /// 10/Auto サイズ。
  static TextStyle get labelSmall => GoogleFonts.delaGothicOne(
    fontWeight: FontWeight.normal,
    fontSize: 10,
    color: AppColors.userPrimary,
    letterSpacing: 0.8,
    height: 1.4,
  );

  /// 中サイズの本文テキストスタイル。
  /// 通常の説明文やコンテンツで使用される。
  /// 16/Auto サイズ。
  static TextStyle get bodyMedium => GoogleFonts.delaGothicOne(
    fontWeight: FontWeight.normal,
    fontSize: 16,
    color: AppColors.white,
    letterSpacing: 0.8,
    height: 1.5,
  );

  /// 小さな本文テキストスタイル。
  /// 補助的な情報や詳細データで使用される。
  /// 12/Auto サイズ。
  static TextStyle get bodySmall => GoogleFonts.delaGothicOne(
    fontWeight: FontWeight.normal,
    fontSize: 12,
    color: AppColors.white,
    letterSpacing: 0.6,
    height: 1.5,
  );
}
