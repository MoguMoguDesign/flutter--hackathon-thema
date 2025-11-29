import 'package:flutter/material.dart';

/// アプリ共通のテキスト入力フィールド。
///
/// 角丸、グレー背景のスタイルで統一されたテキストフィールドコンポーネント。
/// ニックネーム入力や俳句入力などで使用する。
class AppTextField extends StatelessWidget {
  /// テキストフィールドを作成する。
  ///
  /// [controller] はテキストの制御用コントローラー。
  /// [hintText] はプレースホルダーテキスト。
  /// [label] はフィールドの上に表示するラベル。
  /// [onChanged] はテキストが変更された時のコールバック。
  /// [maxLength] は最大文字数。
  /// [autofocus] がtrueの場合、自動的にフォーカスを取得する。
  const AppTextField({
    this.controller,
    this.hintText,
    this.label,
    this.onChanged,
    this.maxLength,
    this.autofocus = false,
    this.textAlign = TextAlign.start,
    super.key,
  });

  /// テキストの制御用コントローラー
  final TextEditingController? controller;

  /// プレースホルダーテキスト
  final String? hintText;

  /// フィールドの上に表示するラベル
  final String? label;

  /// テキストが変更された時のコールバック
  final ValueChanged<String>? onChanged;

  /// 最大文字数
  final int? maxLength;

  /// 自動的にフォーカスを取得するかどうか
  final bool autofocus;

  /// テキストの配置
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    const double height = 64.0;
    const double borderRadius = height / 2; // 完全な丸角

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
        ],
        Container(
          width: 320,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            onChanged: onChanged,
            maxLength: maxLength,
            autofocus: autofocus,
            textAlign: textAlign,
            style: const TextStyle(fontSize: 16, color: Colors.black),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(fontSize: 16, color: Colors.grey.shade500),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 16,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: const BorderSide(color: Colors.black, width: 3.0),
              ),
              counterText: '',
            ),
          ),
        ),
      ],
    );
  }
}
