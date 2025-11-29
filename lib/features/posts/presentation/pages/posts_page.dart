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

import 'package:flutterhackthema/app/app_router/routes.dart';
import '../../../../shared/shared.dart';
import '../../data/models/post.dart';
import '../widgets/post_card.dart';

/// みんなの投稿一覧画面。
class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final posts = Post.mockPosts();

    return AppScaffoldWithBackground(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // スクロール時に消えるヘッダー
            const AppSliverHeader(),
            // Staggered Grid
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              sliver: _SliverStaggeredGrid(
                posts: posts,
                onPostTap: (post) {
                  PostDetailRoute(postId: post.id).go(context);
                },
              ),
            ),
          ],
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
  const _SliverStaggeredGrid({required this.posts, required this.onPostTap});

  final List<Post> posts;
  final void Function(Post) onPostTap;

  @override
  Widget build(BuildContext context) {
    final leftColumn = <Post>[];
    final rightColumn = <Post>[];

    for (var i = 0; i < posts.length; i++) {
      if (i % 2 == 0) {
        leftColumn.add(posts[i]);
      } else {
        rightColumn.add(posts[i]);
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
                    (post) => Padding(
                      padding: const EdgeInsets.all(4),
                      child: PostCard(post: post, onTap: () => onPostTap(post)),
                    ),
                  )
                  .toList(),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                  child: Image.asset(
                    'assets/images/decoration_white.png',
                    width: double.infinity,
                    height: 120,
                    fit: BoxFit.contain,
                  ),
                ),
                ...rightColumn.map(
                  (post) => Padding(
                    padding: const EdgeInsets.all(4),
                    child: PostCard(post: post, onTap: () => onPostTap(post)),
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
