import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../shared/constants/app_colors.dart';

/// 俳句作成のヒントを表示するダイアログ。
///
/// 季語や俳句の作り方のヒントを複数のコンテナで表示する。
class HaikuHintDialog extends StatelessWidget {
  /// [HaikuHintDialog] のコンストラクタ。
  const HaikuHintDialog({
    super.key,
    required this.title,
    required this.hints,
    this.closeText = '閉じる',
  });

  /// ダイアログのタイトル。
  final String title;

  /// ヒントのリスト。
  final List<String> hints;

  /// 閉じるボタンのテキスト。
  final String closeText;

  /// ダイアログを表示するヘルパーメソッド。
  static Future<void> show({
    required BuildContext context,
    required String title,
    required List<String> hints,
    String closeText = '閉じる',
  }) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) => HaikuHintDialog(
        title: title,
        hints: hints,
        closeText: closeText,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
      content: SingleChildScrollView(
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: hints
              .map(
                (hint) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.background.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.background.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    hint,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textBlack,
                      height: 1.5,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
      actions: <Widget>[
        Center(
          child: SizedBox(
            width: 240,
            height: 52,
            child: OutlinedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.textGray,
                side: const BorderSide(color: AppColors.borderGray, width: 2.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26),
                ),
              ),
              child: Text(
                closeText,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: GoogleFonts.rocknRollOne().fontFamily,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

