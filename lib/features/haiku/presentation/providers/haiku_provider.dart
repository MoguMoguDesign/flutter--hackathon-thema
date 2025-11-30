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

import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flutterhackthema/app/app_di/user_providers.dart';
import '../../data/models/haiku_model.dart';
import '../../data/repositories/haiku_repository.dart';

part 'haiku_provider.g.dart';

/// HaikuRepositoryのプロバイダー
///
/// [HaikuRepository]のインスタンスを提供します。
@riverpod
HaikuRepository haikuRepository(Ref ref) {
  return HaikuRepository();
}

/// 俳句一覧のストリームプロバイダー
///
/// Firestoreから俳句一覧をリアルタイムで監視します
@riverpod
Stream<List<HaikuModel>> haikuListStream(Ref ref) {
  final repository = ref.watch(haikuRepositoryProvider);
  return repository.watchAll();
}

/// 俳句保存の状態管理プロバイダー
///
/// 俳句のFirestore保存処理とその状態を管理します。
/// [AsyncValue]を使用して、ローディング・成功・エラー状態を表現します。
@riverpod
class HaikuNotifier extends _$HaikuNotifier {
  final Logger _logger = Logger();

  /// 初期状態を構築
  ///
  /// 初期状態はnullを返します(保存処理未実行)。
  @override
  FutureOr<String?> build() {
    return null;
  }

  /// 俳句をFirestoreに保存
  ///
  /// [firstLine] 上の句
  /// [secondLine] 真ん中の行
  /// [thirdLine] 下の句
  /// [imageUrl] AI生成画像のFirebase Storage URL(オプション)
  ///
  /// Returns: 保存されたドキュメントのID
  ///
  /// Throws: Firestore保存時のエラー
  Future<String> saveHaiku({
    required String firstLine,
    required String secondLine,
    required String thirdLine,
    String? imageUrl,
  }) async {
    _logger.i('Saving haiku to Firestore');

    // async操作前にref参照を取得（disposeエラー回避）
    final repository = ref.read(haikuRepositoryProvider);
    final nicknameFuture = ref.read(userNicknameProvider.future);

    // ローディング状態に設定
    state = const AsyncValue.loading();

    // AsyncValue.guardで例外を安全に処理
    state = await AsyncValue.guard(() async {
      // 現在のユーザーのニックネームを取得（App層経由）
      final String? nickname = await nicknameFuture;

      final haiku = HaikuModel(
        id: '', // Firestoreで自動生成
        firstLine: firstLine,
        secondLine: secondLine,
        thirdLine: thirdLine,
        createdAt: DateTime.now(),
        likeCount: 0, // 初期値として0を設定
        nickname: nickname,
        imageUrl: imageUrl,
      );

      final docId = await repository.create(haiku);
      return docId;
    });

    // エラーの場合は例外を再スロー
    return state.when(
      data: (docId) {
        _logger.i('Haiku saved successfully: $docId');
        return docId!;
      },
      loading: () => throw StateError('Still loading'),
      error: (error, stackTrace) {
        _logger.e('Failed to save haiku', error: error, stackTrace: stackTrace);
        throw error;
      },
    );
  }
}
