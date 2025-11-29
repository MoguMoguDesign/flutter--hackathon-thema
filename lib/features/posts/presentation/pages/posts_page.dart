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
            // 装飾画像
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        'なんか\n装飾画像',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
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
        child: AppFilledButton(
          label: '句を詠む',
          leadingIcon: Icons.add,
          onPressed: () {
            const CreateRoute().go(context);
          },
          width: 160,
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
                const SizedBox(height: 40),
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
