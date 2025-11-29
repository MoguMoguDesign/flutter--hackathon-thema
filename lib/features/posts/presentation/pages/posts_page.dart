import 'package:flutter/material.dart';
import 'package:flutterhackthema/app/app_router/routes.dart';
import 'package:flutterhackthema/features/posts/data/models/post.dart';
import 'package:flutterhackthema/features/posts/presentation/widgets/post_card.dart';
import 'package:flutterhackthema/shared/presentation/widgets/buttons/fab_button.dart';
import 'package:flutterhackthema/shared/presentation/widgets/navigation/app_header.dart';

/// みんなの投稿一覧画面。
class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final posts = Post.mockPosts();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppHeader(),
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: _StaggeredGridView(
                  posts: posts,
                  onPostTap: (post) {
                    PostDetailRoute(postId: post.id).go(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FabButton(
        onPressed: () {
          const CreateRoute().go(context);
        },
      ),
    );
  }
}

class _StaggeredGridView extends StatelessWidget {
  const _StaggeredGridView({required this.posts, required this.onPostTap});

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
