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
import '../../../constants/app_colors.dart';

/// 確認ダイアログコンポーネント。
///
/// 「TOPに戻りますか？」などの確認が必要な場面で使用する。
/// 編集中のデータ破棄確認などに利用する。
class ConfirmDialog extends StatelessWidget {
  /// 確認ダイアログを作成する。
  ///
  /// [title] はダイアログのタイトル。
  /// [message] はダイアログのメッセージ。
  /// [confirmText] は確認ボタンのテキスト。
  /// [cancelText] はキャンセルボタンのテキスト。
  /// [onConfirm] は確認ボタンがタップされた時のコールバック。
  /// [onCancel] はキャンセルボタンがタップされた時のコールバック。
  const ConfirmDialog({
    required this.title,
    required this.message,
    required this.confirmText,
    required this.cancelText,
    required this.onConfirm,
    required this.onCancel,
    super.key,
  });

  /// ダイアログのタイトル
  final String title;

  /// ダイアログのメッセージ
  final String message;

  /// 確認ボタンのテキスト
  final String confirmText;

  /// キャンセルボタンのテキスト
  final String cancelText;

  /// 確認ボタンがタップされた時のコールバック
  final VoidCallback onConfirm;

  /// キャンセルボタンがタップされた時のコールバック
  final VoidCallback onCancel;

  /// 確認ダイアログを表示する。
  ///
  /// [context] はBuildContext。
  /// [title] はダイアログのタイトル。
  /// [message] はダイアログのメッセージ。
  /// [confirmText] は確認ボタンのテキスト。
  /// [cancelText] はキャンセルボタンのテキスト。
  ///
  /// 確認ボタンがタップされた場合はtrue、キャンセルの場合はfalseを返す。
  static Future<bool> show({
    required BuildContext context,
    required String title,
    required String message,
    required String confirmText,
    required String cancelText,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => ConfirmDialog(
        title: title,
        message: message,
        confirmText: confirmText,
        cancelText: cancelText,
        onConfirm: () => Navigator.of(context).pop(true),
        onCancel: () => Navigator.of(context).pop(false),
      ),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              message,
              style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 104,
              child: ElevatedButton(
                onPressed: onConfirm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE53935),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(52),
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
              width: double.infinity,
              height: 104,
              child: OutlinedButton(
                onPressed: onCancel,
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.accent,
                  side: const BorderSide(color: AppColors.accent, width: 2.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(52),
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
      ),
    );
  }
}
