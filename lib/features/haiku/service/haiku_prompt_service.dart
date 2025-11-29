/// 俳句プロンプト生成サービス
///
/// 俳句を画像生成用プロンプトに変換する。
/// 浮世絵風のスタイルと縦書きテキスト埋め込みを指定する。
///
/// 使用例:
/// ```dart
/// final service = HaikuPromptService();
/// final prompt = service.generatePrompt(
///   firstLine: '古池や',
///   secondLine: '蛙飛び込む',
///   thirdLine: '水の音',
/// );
/// ```
class HaikuPromptService {
  /// 俳句プロンプト生成サービスを作成する
  const HaikuPromptService();

  /// 俳句から画像生成プロンプトを生成する
  ///
  /// 3行の俳句を受け取り、Gemini API 用のプロンプト文字列を生成する。
  /// プロンプトには浮世絵風のスタイル指定と、
  /// 俳句テキストの縦書き埋め込み指示が含まれる。
  ///
  /// [firstLine] 上の句（5音）
  /// [secondLine] 中の句（7音）
  /// [thirdLine] 下の句（5音）
  ///
  /// Returns: Gemini API 用のプロンプト文字列
  String generatePrompt({
    required String firstLine,
    required String secondLine,
    required String thirdLine,
  }) {
    final haiku = '$firstLine\n$secondLine\n$thirdLine';
    return '''
$haiku

上記の俳句から連想される情景を浮世絵風に描いてください。

指示:
- 葛飾北斎や歌川広重の画風を参考にした伝統的な日本美術スタイル
- 藍、朱、緑青、黄土など日本の伝統色を使用
- 木版画の摺り跡と和紙の風合いを表現
- 俳句の文字列を画像内に縦書きで配置
- 五七五の区切りで改行して表示
- 余白を大切にした構図
''';
  }

  /// シンプルなプロンプトを生成する
  ///
  /// テキスト埋め込みなしの画像生成用プロンプトを生成する。
  ///
  /// [firstLine] 上の句
  /// [secondLine] 中の句
  /// [thirdLine] 下の句
  ///
  /// Returns: シンプルなプロンプト文字列
  String generateSimplePrompt({
    required String firstLine,
    required String secondLine,
    required String thirdLine,
  }) {
    return '''
「$firstLine $secondLine $thirdLine」

上記の俳句から連想される情景を浮世絵風に描いてください。
葛飾北斎や歌川広重の画風を参考に、日本の伝統色を使用してください。
''';
  }
}
