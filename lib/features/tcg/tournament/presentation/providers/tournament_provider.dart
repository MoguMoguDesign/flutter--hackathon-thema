import 'package:riverpod_annotation/riverpod_annotation.dart';

// Code generation用のpart文
// build_runner実行後に tournament_provider.g.dart が生成される
part 'tournament_provider.g.dart';

/// トーナメント一覧の状態を管理するProvider
///
/// 使用例:
/// ```dart
/// final tournaments = ref.watch(tournamentsProvider);
/// ```
@riverpod
class Tournaments extends _$Tournaments {
  @override
  List<String> build() {
    // 初期状態: 空のリスト
    // 実際のアプリではFirestoreやAPIから取得
    return [];
  }

  /// トーナメントを追加
  void addTournament(String tournamentName) {
    state = [...state, tournamentName];
  }

  /// トーナメントを削除
  void removeTournament(String tournamentName) {
    state = state.where((t) => t != tournamentName).toList();
  }
}

/// 選択中のトーナメントIDを管理するProvider
@riverpod
class SelectedTournament extends _$SelectedTournament {
  @override
  String? build() => null;

  void select(String tournamentId) {
    state = tournamentId;
  }

  void clear() {
    state = null;
  }
}
