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
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

import 'package:flutterhackthema/app/app_router/routes.dart';
import '../../../../shared/shared.dart';
import '../../../../shared/presentation/widgets/navigation/back_button.dart';
import '../../data/models/haiku_model.dart';
import '../providers/haiku_detail_provider.dart';

/// 俳句詳細画面
class HaikuDetailPage extends HookConsumerWidget {
  /// 俳句詳細画面を作成する
  ///
  /// [haikuId] は表示する俳句のID
  const HaikuDetailPage({required this.haikuId, super.key});

  /// ロガーインスタンス
  static final Logger _logger = Logger();

  /// 表示する俳句のID
  final String haikuId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final haikuAsync = ref.watch(haikuDetailProvider(haikuId));

    return AppScaffoldWithBackground(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const AppSliverHeader(),
            SliverToBoxAdapter(
              child: Align(
                alignment: Alignment.centerLeft,
                child: AppBackButton(
                  onPressed: () {
                    const HaikuListRoute().go(context);
                  },
                ),
              ),
            ),
            haikuAsync.when(
              data: (haiku) {
                if (haiku == null) {
                  return _buildError(context, '俳句が見つかりませんでした');
                }
                return _buildLoaded(context, ref, haiku);
              },
              loading: () => _buildLoading(),
              error: (error, stack) => _buildError(context, 'データの読み込みに失敗しました'),
            ),
          ],
        ),
      ),
    );
  }

  /// ローディング状態の表示
  Widget _buildLoading() {
    return const SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
      ),
    );
  }

  /// エラー状態の表示
  Widget _buildError(BuildContext context, String message) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.white70),
              const SizedBox(height: 16),
              Text(
                message,
                style: const TextStyle(fontSize: 16, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              AppFilledButton(
                label: '戻る',
                onPressed: () {
                  const HaikuListRoute().go(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// データ読み込み完了状態の表示
  Widget _buildLoaded(BuildContext context, WidgetRef ref, HaikuModel haiku) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Column(
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: AspectRatio(
                aspectRatio: 4 / 5,
                child: haiku.imageUrl != null
                    ? Image.network(
                        haiku.imageUrl!,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            color: Colors.grey.shade200,
                            child: Center(
                              child: CircularProgressIndicator(
                                value:
                                    loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                    : null,
                                strokeWidth: 2,
                                color: Colors.grey,
                              ),
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          _logger.e(
                            'Failed to load haiku detail image',
                            error: error,
                            stackTrace: stackTrace,
                          );
                          _logger.d('ImageURL: ${haiku.imageUrl}');
                          return _buildFallbackImage(haiku);
                        },
                      )
                    : _buildFallbackImage(haiku),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${haiku.nickname ?? '匿名'} 作',
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                ),
                _buildLikeButton(ref, haiku),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: AppFilledButton(
              label: 'Xでポストする',
              leadingIcon: SvgPicture.asset(
                'assets/images/icon_x.svg',
                width: 20,
                height: 20,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Xでシェアする機能は準備中です'),
                    backgroundColor: Colors.black,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: AppFilledButton(
              label: 'Instagramに投稿する',
              leadingIcon: SvgPicture.asset(
                'assets/images/icon_Instagram.svg',
                width: 20,
                height: 20,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Instagramでシェアする機能は準備中です'),
                    backgroundColor: Colors.black,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  /// いいねボタンの表示
  Widget _buildLikeButton(WidgetRef ref, HaikuModel haiku) {
    return InkWell(
      onTap: () {
        ref.read(likeProvider.notifier).incrementLike(haiku.id);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.favorite_border, color: Colors.white, size: 20),
          const SizedBox(width: 4),
          Text(
            '${haiku.likeCount ?? 0}',
            style: const TextStyle(fontSize: 14, color: Colors.white),
          ),
        ],
      ),
    );
  }

  /// 画像がない場合のフォールバック表示
  Widget _buildFallbackImage(HaikuModel haiku) {
    return Container(
      color: Colors.grey.shade300,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                haiku.firstLine,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                  height: 1.8,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                haiku.secondLine,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                  height: 1.8,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                haiku.thirdLine,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                  height: 1.8,
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
