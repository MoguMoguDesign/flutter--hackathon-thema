import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/presentation/widgets/buttons/fab_button.dart';
import '../../../../shared/presentation/widgets/navigation/app_header.dart';
import '../../data/models/post.dart';
import '../widgets/post_card.dart';

/// みんなの投稿一覧画面。
///
/// 全ユーザーの俳句×画像投稿をStaggered Gridで表示する。
/// ワイヤーフレーム: `みんなの投稿.png`
class PostsPage extends StatelessWidget {
  /// 投稿一覧画面を作成する。
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // モックデータを使用
    final posts = Post.mockPosts();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ヘッダー
            const AppHeader(serviceName: 'サービス名'),
            // 装飾画像エリア
            Padding(
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
            // Staggered Grid
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: _StaggeredGridView(
                  posts: posts,
                  onPostTap: (post) {
                    context.go('/posts/${post.id}');
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FabButton(
        onPressed: () {
          context.go('/create');
        },
      ),
    );
  }
}

/// シンプルなStaggered Grid実装。
///
/// flutter_staggered_grid_viewパッケージを使わずに
/// シンプルな2カラムグリッドで実装。
class _StaggeredGridView extends StatelessWidget {
  const _StaggeredGridView({required this.posts, required this.onPostTap});

  final List<Post> posts;
  final void Function(Post) onPostTap;

  @override
  Widget build(BuildContext context) {
    // 2カラムに分割
    final leftColumn = <Post>[];
    final rightColumn = <Post>[];

    for (var i = 0; i < posts.length; i++) {
      if (i % 2 == 0) {
        leftColumn.add(posts[i]);
      } else {
        rightColumn.add(posts[i]);
      }
    }

    return SingleChildScrollView(
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
                // 右列は少し下にオフセット（Pinterest風）
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
