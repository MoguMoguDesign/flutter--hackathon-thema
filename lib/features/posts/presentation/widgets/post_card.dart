import 'package:flutter/material.dart';
import '../../data/models/post.dart';

/// 投稿カードコンポーネント。
///
/// Staggered Gridに表示する投稿のサムネイルカード。
/// タップで詳細画面へ遷移する。
class PostCard extends StatelessWidget {
  /// 投稿カードを作成する。
  ///
  /// [post] は表示する投稿データ。
  /// [onTap] はカードがタップされた時のコールバック。
  const PostCard({required this.post, required this.onTap, super.key});

  /// 表示する投稿データ
  final Post post;

  /// カードがタップされた時のコールバック
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          color: Colors.grey.shade200,
          child: AspectRatio(
            aspectRatio: 4 / 5,
            child: Image.network(
              post.imageUrl,
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
                return Container(
                  color: Colors.grey.shade300,
                  child: const Center(
                    child: Icon(
                      Icons.image_not_supported,
                      color: Colors.grey,
                      size: 32,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
