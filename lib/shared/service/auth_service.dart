// FLUTTER HACKATHON THEMA - DO NOT DELETE THIS FILE
// This file is managed by AI development rules (CLAUDE.md)
//
// Architecture: Three-Layer (App -> Feature -> Shared)
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

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_service.g.dart';

/// 認証サービス
///
/// Firebase Authentication を使用した認証機能を提供する。
/// 匿名認証によりユーザー登録不要でアプリを利用可能にする。
///
/// 使用例:
/// ```dart
/// final authService = AuthService();
/// final user = await authService.ensureAuthenticated();
/// ```
class AuthService {
  /// コンストラクタ
  ///
  /// [firebaseAuth] テスト時にモックを注入可能
  AuthService({FirebaseAuth? firebaseAuth})
    : _auth = firebaseAuth ?? FirebaseAuth.instance;

  final FirebaseAuth _auth;

  /// テスト用の FirebaseAuth インスタンス
  @visibleForTesting
  static FirebaseAuth? testAuth;

  /// 現在のユーザーを取得
  User? get currentUser => _auth.currentUser;

  /// 認証済みかどうか
  bool get isAuthenticated => currentUser != null;

  /// 現在のユーザーIDを取得
  ///
  /// 未認証の場合はnullを返す。
  String? get currentUserId => currentUser?.uid;

  /// 匿名認証でサインイン
  ///
  /// 既にサインイン済みの場合は現在のユーザーを返す。
  /// Returns: 認証されたユーザー
  /// Throws: [FirebaseAuthException] 認証に失敗した場合
  Future<User> ensureAuthenticated() async {
    if (isAuthenticated) {
      return currentUser!;
    }

    final credential = await _auth.signInAnonymously();
    if (credential.user == null) {
      throw FirebaseAuthException(
        code: 'null-user',
        message: '認証に成功しましたが、ユーザー情報を取得できませんでした',
      );
    }
    return credential.user!;
  }

  /// サインアウト
  ///
  /// 現在のセッションを終了する。
  Future<void> signOut() async {
    await _auth.signOut();
  }

  /// 認証状態の変更を監視
  ///
  /// ユーザーのサインイン/サインアウトを監視するストリームを返す。
  Stream<User?> authStateChanges() {
    return _auth.authStateChanges();
  }
}

/// AuthService プロバイダー
///
/// [AuthService] のインスタンスを提供する。
@riverpod
AuthService authService(Ref ref) {
  return AuthService(firebaseAuth: AuthService.testAuth);
}
