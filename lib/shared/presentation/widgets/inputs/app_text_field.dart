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
        TextField(
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
            fillColor: const Color(0xFFE8E8E8),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 18,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Colors.black, width: 1.5),
            ),
            counterText: '',
          ),
        ),
      ],
    );
  }
}
