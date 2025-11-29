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
import '../../constants/app_colors.dart';

/// アプリケーション全体で使用する統一された確認ダイアログ。
///
/// ユーザーに確認を求める際に使用するダイアログで、
/// タイトル、メッセージ、確認ボタン、キャンセルボタンを表示できる。
class AppConfirmDialog extends StatelessWidget {
  /// [AppConfirmDialog] のコンストラクタ。
  ///
  /// [title] と [message] は必須パラメータ。
  const AppConfirmDialog({
    required this.title,
    required this.message,
    super.key,
    this.confirmText = '確認',
    this.cancelText = 'キャンセル',
    this.onConfirm,
    this.onCancel,
    this.confirmButtonColor,
    this.isDangerous = false,
  });

  /// ダイアログのタイトル。
  final String title;

  /// ダイアログのメッセージ本文。
  final String message;

  /// 確認ボタンのテキスト。
  ///
  /// デフォルトは「確認」。
  final String confirmText;

  /// キャンセルボタンのテキスト。
  ///
  /// デフォルトは「キャンセル」。
  final String cancelText;

  /// 確認ボタンが押されたときのコールバック。
  ///
  /// null の場合、ダイアログを閉じるだけの動作になる。
  final VoidCallback? onConfirm;

  /// キャンセルボタンが押されたときのコールバック。
  ///
  /// null の場合、ダイアログを閉じるだけの動作になる。
  final VoidCallback? onCancel;

  /// 確認ボタンの色（オプション）。
  ///
  /// 指定しない場合、[isDangerous] によって決定される。
  final Color? confirmButtonColor;

  /// 危険なアクション（削除など）を示すフラグ。
  ///
  /// true の場合、確認ボタンが赤色になる。
  /// デフォルトは false。
  final bool isDangerous;

  /// ダイアログを表示するヘルパーメソッド。
  ///
  /// [context] は必須で、他のパラメータは [AppConfirmDialog] と同じ。
  /// 戻り値は bool で、確認された場合は true、キャンセルされた場合は false。
  static Future<bool?> show({
    required BuildContext context,
    required String title,
    required String message,
    String confirmText = '確認',
    String cancelText = 'キャンセル',
    Color? confirmButtonColor,
    bool isDangerous = false,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) => AppConfirmDialog(
        title: title,
        message: message,
        confirmText: confirmText,
        cancelText: cancelText,
        confirmButtonColor: confirmButtonColor,
        isDangerous: isDangerous,
        onConfirm: () => Navigator.of(context).pop(true),
        onCancel: () => Navigator.of(context).pop(false),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color effectiveConfirmButtonColor =
        confirmButtonColor ?? const Color(0xFFE53935);

    return AlertDialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      elevation: 8,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.textBlack,
        ),
      ),
      content: Text(
        message,
        style: const TextStyle(fontSize: 16, color: AppColors.textGray),
      ),
      actions: <Widget>[
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 240,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  if (onConfirm != null) {
                    onConfirm!();
                  } else {
                    Navigator.of(context).pop(true);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: effectiveConfirmButtonColor,
                  foregroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  confirmText,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: GoogleFonts.rocknRollOne().fontFamily,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: 240,
              height: 52,
              child: OutlinedButton(
                onPressed: () {
                  if (onCancel != null) {
                    onCancel!();
                  } else {
                    Navigator.of(context).pop(false);
                  }
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.textGray,
                  side: BorderSide(color: AppColors.borderGray, width: 2.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26),
                  ),
                ),
                child: Text(
                  cancelText,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: GoogleFonts.rocknRollOne().fontFamily,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
