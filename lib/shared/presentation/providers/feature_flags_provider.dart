import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'feature_flags_provider.g.dart';

/// アプリの機能フラグを管理するプロバイダー
///
/// 機能の有効/無効を動的に切り替えることができます
@riverpod
class FeatureFlags extends _$FeatureFlags {
  @override
  FeatureFlagsState build() {
    return const FeatureFlagsState(
      isLikeFeatureEnabled: false,
    );
  }

  /// いいね機能を有効化
  void enableLikeFeature() {
    state = state.copyWith(isLikeFeatureEnabled: true);
  }

  /// いいね機能を無効化
  void disableLikeFeature() {
    state = state.copyWith(isLikeFeatureEnabled: false);
  }

  /// いいね機能のトグル
  void toggleLikeFeature() {
    state = state.copyWith(isLikeFeatureEnabled: !state.isLikeFeatureEnabled);
  }
}

/// 機能フラグの状態を保持するクラス
class FeatureFlagsState {
  const FeatureFlagsState({
    required this.isLikeFeatureEnabled,
  });

  /// いいね機能が有効かどうか
  final bool isLikeFeatureEnabled;

  /// 状態をコピーして新しいインスタンスを作成
  FeatureFlagsState copyWith({
    bool? isLikeFeatureEnabled,
  }) {
    return FeatureFlagsState(
      isLikeFeatureEnabled: isLikeFeatureEnabled ?? this.isLikeFeatureEnabled,
    );
  }
}

/// いいね機能が有効かどうかを取得する便利なプロバイダー
@riverpod
bool isLikeFeatureEnabled(Ref ref) {
  return ref.watch(featureFlagsProvider).isLikeFeatureEnabled;
}
