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
import 'package:logger/logger.dart';

import '../../data/models/haiku_model.dart';

/// 俳句カードコンポーネント
///
/// Staggered Gridに表示する俳句のサムネイルカード。
/// タップで詳細画面へ遷移する。
class HaikuCard extends StatelessWidget {
  /// 俳句カードを作成する
  ///
  /// [haiku] は表示する俳句データ。
  /// [onTap] はカードがタップされた時のコールバック。
  const HaikuCard({required this.haiku, required this.onTap, super.key});

  /// ロガーインスタンス
  static final Logger _logger = Logger();

  /// 表示する俳句データ
  final HaikuModel haiku;

  /// カードがタップされた時のコールバック
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.12),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            color: Colors.grey.shade200,
            child: AspectRatio(
              aspectRatio: 4 / 5,
              child: haiku.imageUrl != null
                  ? Image.network(
                      haiku.imageUrl!,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                : null,
                            strokeWidth: 2,
                            color: Colors.grey,
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        _logger.e(
                          'Failed to load haiku image',
                          error: error,
                          stackTrace: stackTrace,
                        );
                        _logger.d('ImageURL: ${haiku.imageUrl}');
                        return _buildFallbackCard();
                      },
                    )
                  : _buildFallbackCard(),
            ),
          ),
        ),
      ),
    );
  }

  /// 画像がない場合のフォールバックカード
  Widget _buildFallbackCard() {
    return Container(
      color: Colors.grey.shade300,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                haiku.firstLine,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                haiku.secondLine,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                haiku.thirdLine,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
