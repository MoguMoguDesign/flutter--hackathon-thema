// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posts_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// PostRepositoryのプロバイダー
///
/// Firestoreの投稿データにアクセスするためのリポジトリインスタンスを提供します

@ProviderFor(postRepository)
const postRepositoryProvider = PostRepositoryProvider._();

/// PostRepositoryのプロバイダー
///
/// Firestoreの投稿データにアクセスするためのリポジトリインスタンスを提供します

final class PostRepositoryProvider
    extends $FunctionalProvider<PostRepository, PostRepository, PostRepository>
    with $Provider<PostRepository> {
  /// PostRepositoryのプロバイダー
  ///
  /// Firestoreの投稿データにアクセスするためのリポジトリインスタンスを提供します
  const PostRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'postRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$postRepositoryHash();

  @$internal
  @override
  $ProviderElement<PostRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PostRepository create(Ref ref) {
    return postRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PostRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PostRepository>(value),
    );
  }
}

String _$postRepositoryHash() => r'c2dd467ec7a6f4e6037a0ac545ba6d7524a0458f';

/// 投稿一覧のストリームプロバイダー
///
/// Firestoreから投稿一覧をリアルタイムで監視し、作成日時の降順で提供します

@ProviderFor(postsStream)
const postsStreamProvider = PostsStreamProvider._();

/// 投稿一覧のストリームプロバイダー
///
/// Firestoreから投稿一覧をリアルタイムで監視し、作成日時の降順で提供します

final class PostsStreamProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Post>>,
          List<Post>,
          Stream<List<Post>>
        >
    with $FutureModifier<List<Post>>, $StreamProvider<List<Post>> {
  /// 投稿一覧のストリームプロバイダー
  ///
  /// Firestoreから投稿一覧をリアルタイムで監視し、作成日時の降順で提供します
  const PostsStreamProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'postsStreamProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$postsStreamHash();

  @$internal
  @override
  $StreamProviderElement<List<Post>> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<List<Post>> create(Ref ref) {
    return postsStream(ref);
  }
}

String _$postsStreamHash() => r'00fe87c0be570cda33cfb99d87c13d74325f7f08';
