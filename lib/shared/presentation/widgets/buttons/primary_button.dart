import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      height: 64,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // ボタン本体
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFE53935).withValues(alpha: 0.5),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: SizedBox(
                width: double.infinity,
                height: 64,
                child: ElevatedButton(
                  onPressed: isLoading ? null : onPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF040811),
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey.shade400,
                    disabledForegroundColor: Colors.white70,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    elevation: 0,
                  ),
                  child: isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        )
                      : Text(
                          text,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: GoogleFonts.rocknRollOne().fontFamily,
                          ),
                        ),
                ),
              ),
            ),
          ),
          // 右上の装飾画像（上レイヤー）
          Positioned(
            right: -5,
            top: -5,
            child: Image.asset(
              'assets/images/button_decoration.png',
              width: 50,
              height: 50,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
