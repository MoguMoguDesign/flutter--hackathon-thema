import 'package:flutter/material.dart';

/// 主要なアクション用のプライマリボタン。
///
/// 黒背景、白文字、角丸のスタイルで統一されたボタンコンポーネント。
/// 「決定して次の行へ」「Mya句に投稿する」などの主要アクションに使用する。
class PrimaryButton extends StatelessWidget {
  /// プライマリボタンを作成する。
  ///
  /// [text] はボタンに表示するテキスト。
  /// [onPressed] はボタンがタップされた時のコールバック。nullの場合は無効状態になる。
  /// [isLoading] がtrueの場合、ローディングインジケーターを表示する。
  const PrimaryButton({
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    super.key,
  });

  /// ボタンに表示するテキスト
  final String text;

  /// ボタンがタップされた時のコールバック
  final VoidCallback? onPressed;

  /// ローディング状態かどうか
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          disabledBackgroundColor: Colors.grey.shade400,
          disabledForegroundColor: Colors.white70,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          elevation: 0,
        ),
        child: isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
}
