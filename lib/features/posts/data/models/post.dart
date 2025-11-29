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

/// 投稿データモデル。
///
/// 俳句と生成画像の投稿情報を保持する。
class Post {
  /// 投稿を作成する。
  const Post({
    required this.id,
    required this.nickname,
    required this.haiku,
    required this.imageUrl,
    required this.createdAt,
    this.likeCount = 0,
  });

  /// 投稿ID
  final String id;

  /// 投稿者のニックネーム
  final String nickname;

  /// 俳句テキスト（上の句、中の句、下の句）
  final String haiku;

  /// 生成画像のURL
  final String imageUrl;

  /// 投稿日時
  final DateTime createdAt;

  /// いいね数
  final int likeCount;

  /// モックデータを生成する。
  static List<Post> mockPosts() {
    return [
      Post(
        id: '1',
        nickname: 'なほもり',
        haiku: '古池や\n蛙飛び込む\n水の音',
        imageUrl: 'https://picsum.photos/400/500?random=1',
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        likeCount: 15,
      ),
      Post(
        id: '2',
        nickname: '松尾',
        haiku: '閑さや\n岩にしみ入る\n蝉の声',
        imageUrl: 'https://picsum.photos/400/500?random=2',
        createdAt: DateTime.now().subtract(const Duration(hours: 5)),
        likeCount: 23,
      ),
      Post(
        id: '3',
        nickname: '与謝蕪村',
        haiku: '菜の花や\n月は東に\n日は西に',
        imageUrl: 'https://picsum.photos/400/500?random=3',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        likeCount: 8,
      ),
      Post(
        id: '4',
        nickname: '小林一茶',
        haiku: '雪とけて\n村いっぱいの\n子どもかな',
        imageUrl: 'https://picsum.photos/400/500?random=4',
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        likeCount: 31,
      ),
      Post(
        id: '5',
        nickname: '正岡子規',
        haiku: '柿くへば\n鐘が鳴るなり\n法隆寺',
        imageUrl: 'https://picsum.photos/400/500?random=5',
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
        likeCount: 42,
      ),
      Post(
        id: '6',
        nickname: '山田太郎',
        haiku: '夏草や\n兵どもが\n夢の跡',
        imageUrl: 'https://picsum.photos/400/500?random=6',
        createdAt: DateTime.now().subtract(const Duration(days: 4)),
        likeCount: 19,
      ),
    ];
  }
}
