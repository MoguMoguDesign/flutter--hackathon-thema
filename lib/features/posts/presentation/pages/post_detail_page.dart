import 'package:flutter/material.dart';

import 'package:flutterhackthema/app/app_router/routes.dart';
import '../../../../shared/shared.dart';
import '../../../../shared/presentation/widgets/navigation/back_button.dart';
import '../../data/models/post.dart';

/// 投稿詳細画面。
class PostDetailPage extends StatelessWidget {
  const PostDetailPage({required this.postId, super.key});

  final String postId;

  @override
  Widget build(BuildContext context) {
    final posts = Post.mockPosts();
    final post = posts.firstWhere(
      (p) => p.id == postId,
      orElse: () => posts.first,
    );

    void handleBack() {
      const PostsRoute().go(context);
    }

    void handleShareToX() {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Xでシェアする機能は準備中です'),
          backgroundColor: Colors.black,
        ),
      );
    }

    void handleShareToInstagram() {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Instagramでシェアする機能は準備中です'),
          backgroundColor: Colors.black,
        ),
      );
    }

    return AppScaffoldWithBackground(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const AppSliverHeader(),
            SliverToBoxAdapter(
              child: Align(
                alignment: Alignment.centerLeft,
                child: AppBackButton(onPressed: handleBack),
              ),
            ),
            SliverFillRemaining(
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
                        child: Image.network(
                          post.imageUrl,
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
                            return Container(
                              color: Colors.grey.shade200,
                              child: const Center(
                                child: Icon(
                                  Icons.image_not_supported,
                                  color: Colors.grey,
                                  size: 48,
                                ),
                              ),
                            );
                          },
                        ),
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
                          '${post.nickname} 作',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.favorite_border,
                              size: 20,
                              color: Colors.grey.shade600,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${post.likeCount}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: AppFilledButton(
                      label: 'Xでポストする',
                      leadingIcon: Icons.close,
                      onPressed: handleShareToX,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: AppFilledButton(
                      label: 'Instagramに投稿する',
                      leadingIcon: Icons.camera_alt_outlined,
                      onPressed: handleShareToInstagram,
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
