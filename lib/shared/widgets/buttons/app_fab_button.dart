import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/app_colors.dart';

/// アプリケーション共通のFloating Action Button。
///
/// 「+ 句を詠む」などの新規作成アクションで使用する。
/// テキストとアイコン付きの拡張FABスタイル。
class AppFabButton extends StatelessWidget {
  /// FABボタンを作成する。
  ///
  /// [onPressed] はボタンがタップされた時のコールバック。
  /// [label] はボタンに表示するテキスト。デフォルトは「句を詠む」。
  /// [icon] はボタンに表示するアイコン。デフォルトは追加アイコン。
  const AppFabButton({
    required this.onPressed,
    this.label = '句を詠む',
    this.icon = Icons.add,
    super.key,
  });

  /// ボタンがタップされた時のコールバック
  final VoidCallback onPressed;

  /// ボタンに表示するテキスト
  final String label;

  /// ボタンに表示するアイコン
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: Stack(
        children: [
          // 左上の装飾SVG（下レイヤー）
          Positioned(
            left: -25,
            top: -5,
            child: Transform.rotate(
              angle: 3.14159, // 180度回転
              child: SvgPicture.asset(
                'assets/images/decoration.svg',
                width: 60,
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
          ),
          // 右下の装飾SVG（下レイヤー）
          Positioned(
            right: -25,
            bottom: -5,
            child: SvgPicture.asset(
              'assets/images/button_decoration.svg',
              width: 60,
              height: 40,
              fit: BoxFit.cover,
            ),
          ),
          // FABボタン本体（上レイヤー）
          FloatingActionButton.extended(
            onPressed: onPressed,
            backgroundColor: AppColors.primaryBlue,
            foregroundColor: AppColors.white,
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ),
            extendedIconLabelSpacing: 4,
            icon: Icon(icon, size: 20),
            label: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: GoogleFonts.rocknRollOne().fontFamily,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
