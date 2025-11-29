import 'package:flutter/material.dart';

/// ローディングインジケーターコンポーネント。
///
/// 画像生成中などの待機状態を表示する。
/// テキストメッセージと共に表示される。
class LoadingIndicator extends StatelessWidget {
  /// ローディングインジケーターを作成する。
  ///
  /// [message] は表示するメッセージ。デフォルトは「読み込み中...」。
  const LoadingIndicator({this.message = '読み込み中...', super.key});

  /// 表示するメッセージ
  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black54),
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          message,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
