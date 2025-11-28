// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tournament_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// トーナメント一覧の状態を管理するProvider
///
/// 使用例:
/// ```dart
/// final tournaments = ref.watch(tournamentsProvider);
/// ```

@ProviderFor(Tournaments)
const tournamentsProvider = TournamentsProvider._();

/// トーナメント一覧の状態を管理するProvider
///
/// 使用例:
/// ```dart
/// final tournaments = ref.watch(tournamentsProvider);
/// ```
final class TournamentsProvider
    extends $NotifierProvider<Tournaments, List<String>> {
  /// トーナメント一覧の状態を管理するProvider
  ///
  /// 使用例:
  /// ```dart
  /// final tournaments = ref.watch(tournamentsProvider);
  /// ```
  const TournamentsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tournamentsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tournamentsHash();

  @$internal
  @override
  Tournaments create() => Tournaments();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<String>>(value),
    );
  }
}

String _$tournamentsHash() => r'0c5694f84c826091abe64a71eba2bcccbeed5a80';

/// トーナメント一覧の状態を管理するProvider
///
/// 使用例:
/// ```dart
/// final tournaments = ref.watch(tournamentsProvider);
/// ```

abstract class _$Tournaments extends $Notifier<List<String>> {
  List<String> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<List<String>, List<String>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<String>, List<String>>,
              List<String>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// 選択中のトーナメントIDを管理するProvider

@ProviderFor(SelectedTournament)
const selectedTournamentProvider = SelectedTournamentProvider._();

/// 選択中のトーナメントIDを管理するProvider
final class SelectedTournamentProvider
    extends $NotifierProvider<SelectedTournament, String?> {
  /// 選択中のトーナメントIDを管理するProvider
  const SelectedTournamentProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedTournamentProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedTournamentHash();

  @$internal
  @override
  SelectedTournament create() => SelectedTournament();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$selectedTournamentHash() =>
    r'd8fd73c8244ec91cdc86cedff270dad09475d31a';

/// 選択中のトーナメントIDを管理するProvider

abstract class _$SelectedTournament extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<String?, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String?, String?>,
              String?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
