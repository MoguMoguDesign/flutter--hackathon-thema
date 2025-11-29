import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutterhackthema/features/posts/data/models/post.dart';
import 'package:flutterhackthema/features/posts/data/repositories/post_repository.dart';

/// テスト用のPostRepository (FakeFirebaseFirestoreを注入)
class TestPostRepository extends PostRepository {
  TestPostRepository({required FakeFirebaseFirestore fakeFirestore})
    : _fakeFirestore = fakeFirestore;

  final FakeFirebaseFirestore _fakeFirestore;

  @override
  FirebaseFirestore get firestore => _fakeFirestore;
}

void main() {
  group('PostRepository', () {
    late FakeFirebaseFirestore fakeFirestore;
    late TestPostRepository repository;

    setUp(() {
      fakeFirestore = FakeFirebaseFirestore();
      repository = TestPostRepository(fakeFirestore: fakeFirestore);
    });

    group('create', () {
      test('creates post with auto-generated ID', () async {
        // Arrange
        final post = Post(
          id: '', // auto-generated
          nickname: 'テストユーザー',
          haiku: '古池や\n蛙飛び込む\n水の音',
          imageUrl: 'https://example.com/image.png',
          createdAt: DateTime(2025, 1, 1),
          likeCount: 0,
        );

        // Act
        final docId = await repository.create(post);

        // Assert
        expect(docId, isNotEmpty);

        final doc = await repository.collection.doc(docId).get();
        expect(doc.exists, isTrue);
        expect(doc.data()!['nickname'], equals('テストユーザー'));
        expect(doc.data()!['haiku'], equals('古池や\n蛙飛び込む\n水の音'));
      });

      test('creates post with custom ID', () async {
        // Arrange
        const customId = 'custom-post-id';
        final post = Post(
          id: customId,
          nickname: 'カスタムユーザー',
          haiku: '閑さや\n岩にしみ入る\n蝉の声',
          imageUrl: 'https://example.com/custom.png',
          createdAt: DateTime(2025, 1, 1),
          likeCount: 5,
        );

        // Act
        final docId = await repository.create(post, docId: customId);

        // Assert
        expect(docId, equals(customId));

        final doc = await repository.collection.doc(customId).get();
        expect(doc.exists, isTrue);
        expect(doc.data()!['nickname'], equals('カスタムユーザー'));
        expect(doc.data()!['likeCount'], equals(5));
      });

      test('creates post without ID field in Firestore document', () async {
        // Arrange
        final post = Post(
          id: 'test-id',
          nickname: 'テストユーザー',
          haiku: '古池や\n蛙飛び込む\n水の音',
          imageUrl: 'https://example.com/image.png',
          createdAt: DateTime(2025, 1, 1),
        );

        // Act
        await repository.create(post, docId: 'test-id');

        // Assert
        final doc = await repository.collection.doc('test-id').get();
        final data = doc.data()!;
        expect(data.containsKey('id'), isFalse); // IDはドキュメントに保存されない
      });
    });

    group('read', () {
      test('reads existing post', () async {
        // Arrange
        const docId = 'test-post';
        final post = Post(
          id: docId,
          nickname: 'テストユーザー',
          haiku: '菜の花や\n月は東に\n日は西に',
          imageUrl: 'https://example.com/flower.png',
          createdAt: DateTime(2025, 1, 1),
          likeCount: 10,
        );
        await repository.create(post, docId: docId);

        // Act
        final result = await repository.read(docId);

        // Assert
        expect(result, isNotNull);
        expect(result!.id, equals(docId));
        expect(result.nickname, equals('テストユーザー'));
        expect(result.haiku, equals('菜の花や\n月は東に\n日は西に'));
        expect(result.likeCount, equals(10));
      });

      test('returns null for non-existent post', () async {
        // Act
        final result = await repository.read('non-existent');

        // Assert
        expect(result, isNull);
      });
    });

    group('update', () {
      test('updates existing post', () async {
        // Arrange
        const docId = 'update-test';
        final original = Post(
          id: docId,
          nickname: 'オリジナルユーザー',
          haiku: '雪とけて\n村いっぱいの\n子どもかな',
          imageUrl: 'https://example.com/original.png',
          createdAt: DateTime(2025, 1, 1),
          likeCount: 5,
        );
        await repository.create(original, docId: docId);

        // Act - いいね数を増やす
        final updated = Post(
          id: docId,
          nickname: 'オリジナルユーザー',
          haiku: '雪とけて\n村いっぱいの\n子どもかな',
          imageUrl: 'https://example.com/original.png',
          createdAt: DateTime(2025, 1, 1),
          likeCount: 15,
        );
        await repository.update(docId, updated);

        // Assert
        final result = await repository.read(docId);
        expect(result!.likeCount, equals(15));
      });
    });

    group('delete', () {
      test('deletes existing post', () async {
        // Arrange
        const docId = 'delete-test';
        final post = Post(
          id: docId,
          nickname: 'テストユーザー',
          haiku: '柿くへば\n鐘が鳴るなり\n法隆寺',
          imageUrl: 'https://example.com/kaki.png',
          createdAt: DateTime(2025, 1, 1),
        );
        await repository.create(post, docId: docId);

        // Act
        await repository.delete(docId);

        // Assert
        final result = await repository.read(docId);
        expect(result, isNull);
      });
    });

    group('readAll', () {
      test('returns all posts', () async {
        // Arrange
        final post1 = Post(
          id: 'post-1',
          nickname: 'ユーザー1',
          haiku: '古池や\n蛙飛び込む\n水の音',
          imageUrl: 'https://example.com/1.png',
          createdAt: DateTime(2025, 1, 1),
          likeCount: 10,
        );
        final post2 = Post(
          id: 'post-2',
          nickname: 'ユーザー2',
          haiku: '閑さや\n岩にしみ入る\n蝉の声',
          imageUrl: 'https://example.com/2.png',
          createdAt: DateTime(2025, 1, 2),
          likeCount: 5,
        );

        await repository.create(post1, docId: 'post-1');
        await repository.create(post2, docId: 'post-2');

        // Act
        final results = await repository.readAll();

        // Assert
        expect(results, hasLength(2));
        expect(results.map((p) => p.nickname), containsAll(['ユーザー1', 'ユーザー2']));
      });

      test('returns empty list when no posts exist', () async {
        // Act
        final results = await repository.readAll();

        // Assert
        expect(results, isEmpty);
      });
    });

    group('watchAllPosts', () {
      test('returns stream of posts ordered by createdAt descending', () async {
        // Arrange
        final post1 = Post(
          id: 'post-1',
          nickname: 'ユーザー1',
          haiku: '古池や\n蛙飛び込む\n水の音',
          imageUrl: 'https://example.com/1.png',
          createdAt: DateTime(2025, 1, 1),
          likeCount: 10,
        );
        final post2 = Post(
          id: 'post-2',
          nickname: 'ユーザー2',
          haiku: '閑さや\n岩にしみ入る\n蝉の声',
          imageUrl: 'https://example.com/2.png',
          createdAt: DateTime(2025, 1, 3), // より新しい
          likeCount: 5,
        );
        final post3 = Post(
          id: 'post-3',
          nickname: 'ユーザー3',
          haiku: '菜の花や\n月は東に\n日は西に',
          imageUrl: 'https://example.com/3.png',
          createdAt: DateTime(2025, 1, 2),
          likeCount: 15,
        );

        await repository.create(post1, docId: 'post-1');
        await repository.create(post2, docId: 'post-2');
        await repository.create(post3, docId: 'post-3');

        // Act
        final stream = repository.watchAllPosts();
        final results = await stream.first;

        // Assert
        expect(results, hasLength(3));
        // 降順なので、最新(post2)が最初
        expect(results[0].id, equals('post-2'));
        expect(results[1].id, equals('post-3'));
        expect(results[2].id, equals('post-1'));
      });

      test('stream emits updates when posts are added', () async {
        // Arrange
        final stream = repository.watchAllPosts();
        final emittedValues = <List<Post>>[];

        // Act
        final subscription = stream.listen(emittedValues.add);

        // 初期状態を待つ
        await Future<void>.delayed(const Duration(milliseconds: 100));

        // 投稿を追加
        final post = Post(
          id: 'new-post',
          nickname: 'テストユーザー',
          haiku: '古池や\n蛙飛び込む\n水の音',
          imageUrl: 'https://example.com/new.png',
          createdAt: DateTime(2025, 1, 1),
        );
        await repository.create(post, docId: 'new-post');

        // 更新を待つ
        await Future<void>.delayed(const Duration(milliseconds: 100));

        // Assert
        expect(emittedValues.length, greaterThanOrEqualTo(2));
        expect(emittedValues.first, isEmpty); // 初期状態は空
        expect(emittedValues.last, hasLength(1)); // 投稿追加後は1件
        expect(emittedValues.last.first.id, equals('new-post'));

        await subscription.cancel();
      });

      test('returns empty stream when no posts exist', () async {
        // Act
        final stream = repository.watchAllPosts();
        final results = await stream.first;

        // Assert
        expect(results, isEmpty);
      });
    });

    group('fromFirestore', () {
      test('includes document ID in Post model', () async {
        // Arrange
        const docId = 'test-post';
        final post = Post(
          id: docId,
          nickname: 'テストユーザー',
          haiku: '古池や\n蛙飛び込む\n水の音',
          imageUrl: 'https://example.com/image.png',
          createdAt: DateTime(2025, 1, 1),
        );
        await repository.create(post, docId: docId);

        // Act
        final result = await repository.read(docId);

        // Assert
        expect(result!.id, equals(docId)); // ドキュメントIDがモデルに含まれる
      });

      test('throws exception when document data is null', () async {
        // Arrange - Create a document then delete its data
        const docId = 'null-data-test';
        await repository.collection.doc(docId).set(<String, dynamic>{});
        await repository.collection.doc(docId).delete();

        // Act & Assert
        final result = await repository.read(docId);
        expect(result, isNull);
      });
    });
  });
}
