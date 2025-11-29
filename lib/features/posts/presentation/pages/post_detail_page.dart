import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/presentation/widgets/navigation/app_header.dart';
import '../../../../shared/presentation/widgets/navigation/back_button.dart';
import '../../data/models/post.dart';

/// 投稿詳細画面。
///
/// 俳句×画像の詳細を表示し、SNSシェア機能を提供する。
/// ワイヤーフレーム: `詳細ページ.png`
class PostDetailPage extends StatelessWidget {
  /// 投稿詳細画面を作成する。
  ///
  /// [postId] は表示する投稿のID。
  const PostDetailPage({required this.postId, super.key});

  /// 表示する投稿のID
  final String postId;

  @override
  Widget build(BuildContext context) {
    // モックデータから投稿を取得
    final posts = Post.mockPosts();
    final post = posts.firstWhere(
      (p) => p.id == postId,
      orElse: () => posts.first,
    );

    void handleBack() {
      context.go('/posts');
    }

    void handleShareToX() {
      // モック: X（Twitter）シェア
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Xでシェアする機能は準備中です'),
          backgroundColor: Colors.black,
        ),
      );
    }

    void handleShareToInstagram() {
      // モック: Instagramシェア
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Instagramでシェアする機能は準備中です'),
          backgroundColor: Colors.black,
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ヘッダー
            const AppHeader(serviceName: 'サービス名'),
            // 戻るボタン
            Align(
              alignment: Alignment.centerLeft,
              child: AppBackButton(onPressed: handleBack),
            ),
            const SizedBox(height: 16),
            // 画像
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
                            value: loadingProgress.expectedTotalBytes != null
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
            // 作者名といいね
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 作者名
                  Text(
                    '${post.nickname} 作',
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  // いいね
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
            // Xでポストするボタン
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: _SnsShareButton(
                icon: Icons.close, // X（旧Twitter）のアイコン代替
                label: 'Xでポストする',
                onPressed: handleShareToX,
              ),
            ),
            const SizedBox(height: 12),
            // Instagramに投稿するボタン
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: _SnsShareButton(
                icon: Icons.camera_alt_outlined,
                label: 'Instagramに投稿する',
                onPressed: handleShareToInstagram,
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

/// SNSシェアボタンコンポーネント。
class _SnsShareButton extends StatelessWidget {
  const _SnsShareButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
