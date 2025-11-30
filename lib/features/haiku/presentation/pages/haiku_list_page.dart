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

import 'package:flutterhackthema/app/app_router/routes.dart';
import '../../../../shared/shared.dart';
import '../../data/models/haiku_model.dart';
import '../providers/haiku_provider.dart';
import '../widgets/haiku_card.dart';

/// みんなの俳句一覧画面
class HaikuListPage extends HookConsumerWidget {
  const HaikuListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final haikusAsync = ref.watch(haikuListStreamProvider);

    return AppScaffoldWithBackground(
      body: SafeArea(
        child: haikusAsync.when(
          data: (haikus) => CustomScrollView(
            slivers: [
              // スクロール時に消えるヘッダー
              const AppSliverHeader(),
              // Staggered Grid
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                sliver: _SliverStaggeredGrid(
                  haikus: haikus,
                  onHaikuTap: (haiku) {
                    HaikuDetailRoute(haikuId: haiku.id).go(context);
                  },
                ),
              ),
            ],
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 64,
                  color: AppColors.error,
                ),
                const SizedBox(height: 16),
                Text(
                  'エラーが発生しました',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  error.toString(),
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 8, right: 8),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // 左上の装飾SVG（下レイヤー）
            Positioned(
              left: -20,
              top: -12,
              child: Transform.rotate(
                angle: 3.14159, // 180度回転
                child: SvgPicture.asset(
                  'assets/images/button_decoration.svg',
                  width: 55,
                  height: 45,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            // 右下の装飾SVG（下レイヤー）
            Positioned(
              right: -20,
              bottom: -12,
              child: SvgPicture.asset(
                'assets/images/button_decoration.svg',
                width: 55,
                height: 45,
                fit: BoxFit.contain,
              ),
            ),
            // FABボタン本体（正円・大きめ・上レイヤー）
            SizedBox(
              width: 96,
              height: 96,
              child: FloatingActionButton(
                onPressed: () {
                  const CreateRoute().go(context);
                },
                backgroundColor: AppColors.accent,
                foregroundColor: Colors.white,
                elevation: 8,
                shape: const CircleBorder(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.add, size: 32),
                    const SizedBox(height: 4),
                    const Text(
                      '句を詠む',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SliverStaggeredGrid extends StatelessWidget {
  const _SliverStaggeredGrid({required this.haikus, required this.onHaikuTap});

  final List<HaikuModel> haikus;
  final void Function(HaikuModel) onHaikuTap;

  @override
  Widget build(BuildContext context) {
    final leftColumn = <HaikuModel>[];
    final rightColumn = <HaikuModel>[];

    for (var i = 0; i < haikus.length; i++) {
      if (i % 2 == 0) {
        leftColumn.add(haikus[i]);
      } else {
        rightColumn.add(haikus[i]);
      }
    }

    return SliverToBoxAdapter(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              children: leftColumn
                  .map(
                    (haiku) => Padding(
                      padding: const EdgeInsets.all(4),
                      child: HaikuCard(
                        haiku: haiku,
                        onTap: () => onHaikuTap(haiku),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 4,
                  ),
                  child: Image.asset(
                    'assets/images/decoration_white.png',
                    width: double.infinity,
                    height: 120,
                    fit: BoxFit.contain,
                  ),
                ),
                ...rightColumn.map(
                  (haiku) => Padding(
                    padding: const EdgeInsets.all(4),
                    child: HaikuCard(
                      haiku: haiku,
                      onTap: () => onHaikuTap(haiku),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
