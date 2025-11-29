import 'package:flutter/material.dart';
import '../buttons/primary_button.dart';
import '../buttons/secondary_button.dart';

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
            PrimaryButton(text: confirmText, onPressed: onConfirm),
            const SizedBox(height: 12),
            SecondaryButton(text: cancelText, onPressed: onCancel),
          ],
        ),
      ),
    );
  }
}
