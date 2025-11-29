import 'package:flutterhackthema/shared/models/image_generation_result.dart';

/// スタブ関数（非Web環境用）
///
/// この関数は実際には呼び出されない。
/// 条件付きインポートでWebではない場合にこのファイルが使用される。
Future<ImageGenerationResult> generateImageWeb({
  required String prompt,
  String aspectRatio = '4:5',
}) {
  throw UnsupportedError('generateImageWeb is only supported on web');
}
