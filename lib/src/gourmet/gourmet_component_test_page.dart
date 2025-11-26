import 'package:flutter/material.dart';
import 'package:flutterhackthema/gourmet_ui.dart';

/// My Gourmetコンポーネントテスト用のページを表示する。
///
/// 各種 UI コンポーネントの表示確認とテストを行う。
class GourmetComponentTestPage extends StatelessWidget {
  /// [GourmetComponentTestPage] のコンストラクタ。
  const GourmetComponentTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Gourmet コンポーネント'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'My Gourmet UI コンポーネントテストページ',
                style: context.textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              // ✅ AppElevatedButton
              Text(
                '✅ AppElevatedButton',
                style: context.textTheme.titleMedium,
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 12),
              AppElevatedButton(
                text: 'プライマリボタン',
                onPressed: () {
                  AppSnackBar.show(
                    context,
                    message: 'プライマリボタンが押されました',
                  );
                },
              ),
              const SizedBox(height: 16),
              AppElevatedButton(
                text: 'カスタムカラーボタン',
                backgroundColor: Themes.gray.shade700,
                borderColor: Themes.gray.shade900,
                onPressed: () {
                  AppSnackBar.show(
                    context,
                    message: 'カスタムカラーボタンが押されました',
                  );
                },
              ),
              const SizedBox(height: 16),
              AppElevatedButton(
                text: 'アイコン付きボタン',
                widget: const Icon(Icons.star, color: Colors.white),
                onPressed: () {
                  AppSnackBar.show(
                    context,
                    message: 'アイコン付きボタンが押されました',
                  );
                },
              ),
              const SizedBox(height: 32),

              // ✅ AppDialog
              Text(
                '✅ AppDialog',
                style: context.textTheme.titleMedium,
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 12),
              AppElevatedButton(
                text: 'ダイアログ表示',
                backgroundColor: Themes.mainOrange.shade700,
                onPressed: () async {
                  await AppDialog.show(
                    context,
                    titleString: '確認',
                    contentString: 'この操作を実行しますか?',
                    hasCancelButton: true,
                    onConfirmed: () {
                      AppSnackBar.show(
                        context,
                        message: '確認されました',
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 16),
              AppElevatedButton(
                text: '破滅的アクション',
                backgroundColor: Themes.errorAlertColor,
                borderColor: Themes.gray.shade900,
                onPressed: () async {
                  await AppDialog.show(
                    context,
                    titleString: '警告',
                    contentString: 'この操作は取り消せません。続行しますか?',
                    hasCancelButton: true,
                    isDestructiveAction: true,
                    onConfirmed: () {
                      AppSnackBar.show(
                        context,
                        message: '削除されました',
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 32),

              // ✅ GuruMemoCard
              Text(
                '✅ GuruMemoCard',
                style: context.textTheme.titleMedium,
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 12),
              GuruMemoCard(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'カードタイトル',
                        style: context.textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'これはGuruMemoCardの例です。カスタムボーダーと影を持つカードウィジェットです。',
                        style: context.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              GuruMemoCard(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.restaurant,
                        size: 48,
                        color: Themes.mainOrange,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'レストラン情報',
                              style: context.textTheme.titleSmall,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'おいしいお店の情報をカードで表示',
                              style: context.textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // テーマカラー
              Text(
                '✅ テーマカラー',
                style: context.textTheme.titleMedium,
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _ColorChip(
                    color: Themes.mainOrange,
                    label: 'Main Orange',
                  ),
                  _ColorChip(
                    color: Themes.gray,
                    label: 'Gray',
                  ),
                  _ColorChip(
                    color: Themes.errorAlertColor,
                    label: 'Error',
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // SnackBar テスト
              Text(
                '✅ AppSnackBar',
                style: context.textTheme.titleMedium,
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 12),
              AppElevatedButton(
                text: 'SnackBar表示',
                onPressed: () {
                  AppSnackBar.show(
                    context,
                    message: 'これはテストメッセージです',
                    actionLabel: '閉じる',
                    onActionPressed: () {
                      // アクションの処理
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ColorChip extends StatelessWidget {
  const _ColorChip({
    required this.color,
    required this.label,
  });

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Themes.gray.shade900),
      ),
      child: Text(
        label,
        style: context.textTheme.bodySmall?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
