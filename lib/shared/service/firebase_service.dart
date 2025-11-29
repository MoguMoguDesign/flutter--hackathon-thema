import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

/// Firebase サービスへのアクセスを提供するユーティリティクラス
///
/// Firestore と Storage のインスタンスへの統一的なアクセスポイントを提供する。
/// 各サービスのインスタンスはシングルトンとして管理される。
///
/// 使用例:
/// ```dart
/// final firestore = FirebaseService.firestore;
/// final storage = FirebaseService.storage;
/// ```
class FirebaseService {
  /// プライベートコンストラクタ（インスタンス化を防ぐ）
  FirebaseService._();

  /// Cloud Firestore インスタンス
  ///
  /// データベース操作に使用する。
  /// 本番環境とテスト環境で自動的に適切なインスタンスが返される。
  static FirebaseFirestore get firestore => FirebaseFirestore.instance;

  /// Firebase Storage インスタンス
  ///
  /// ファイルアップロード・ダウンロード操作に使用する。
  /// 本番環境とテスト環境で自動的に適切なインスタンスが返される。
  static FirebaseStorage get storage => FirebaseStorage.instance;
}
