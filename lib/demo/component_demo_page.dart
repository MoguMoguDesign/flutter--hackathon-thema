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

import 'package:flutter/material.dart';
import '../shared/shared.dart';

/// 共通コンポーネントのデモページ。
///
/// 作成した各コンポーネントの動作確認とレイアウト確認用。
class ComponentDemoPage extends StatelessWidget {
  /// [ComponentDemoPage] のコンストラクタ。
  const ComponentDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('コンポーネントデモ'),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('情報ボタンが押されました')));
            },
          ),
        ],
      ),
      body: AppBody(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'ボタンコンポーネント',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textBlack,
              ),
            ),
            const SizedBox(height: 16),

            // Filled Button - 基本
            AppFilledButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Filled Buttonが押されました')),
                );
              },
              label: '基本のFilledボタン',
            ),
            const SizedBox(height: 12),

            // Filled Button - アイコン付き
            AppFilledButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('アイコン付きボタンが押されました')),
                );
              },
              label: '送信',
              leadingIcon: Icons.send,
            ),
            const SizedBox(height: 12),

            // Filled Button - ローディング
            const AppFilledButton(
              onPressed: null,
              label: '読み込み中...',
              isLoading: true,
            ),
            const SizedBox(height: 12),

            // Filled Button - 無効状態
            const AppFilledButton(onPressed: null, label: '無効なボタン'),
            const SizedBox(height: 24),

            // Outlined Button - 基本
            AppOutlinedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Outlined Buttonが押されました')),
                );
              },
              label: '基本のOutlinedボタン',
            ),
            const SizedBox(height: 12),

            // Outlined Button - アイコン付き
            AppOutlinedButton(
              onPressed: () {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('削除ボタンが押されました')));
              },
              label: '削除',
              leadingIcon: Icons.delete,
              foregroundColor: AppColors.error,
              borderColor: AppColors.error,
            ),
            const SizedBox(height: 12),

            // Outlined Button - 無効状態
            const AppOutlinedButton(onPressed: null, label: '無効なOutlinedボタン'),
            const SizedBox(height: 24),

            const Text(
              'ダイアログコンポーネント',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textBlack,
              ),
            ),
            const SizedBox(height: 16),

            // 通常の確認ダイアログ
            AppFilledButton(
              onPressed: () async {
                final bool? result = await AppConfirmDialog.show(
                  context: context,
                  title: '保存確認',
                  message: '変更を保存しますか？',
                  confirmText: '保存',
                  cancelText: 'キャンセル',
                );

                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(result == true ? '保存されました' : 'キャンセルされました'),
                    ),
                  );
                }
              },
              label: '通常の確認ダイアログを表示',
              leadingIcon: Icons.save,
            ),
            const SizedBox(height: 12),

            // 危険なアクションの確認ダイアログ
            AppOutlinedButton(
              onPressed: () async {
                final bool? result = await AppConfirmDialog.show(
                  context: context,
                  title: '削除確認',
                  message: 'このアイテムを削除しますか？この操作は取り消せません。',
                  confirmText: '削除',
                  cancelText: 'キャンセル',
                  isDangerous: true,
                );

                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(result == true ? '削除されました' : 'キャンセルされました'),
                    ),
                  );
                }
              },
              label: '危険な確認ダイアログを表示',
              leadingIcon: Icons.warning,
              foregroundColor: AppColors.error,
              borderColor: AppColors.error,
            ),
            const SizedBox(height: 24),

            const Text(
              'レイアウト情報',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textBlack,
              ),
            ),
            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.backgroundLight,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.borderLight),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '✅ AppFilledButton: 塗りつぶしボタン',
                    style: TextStyle(color: AppColors.textBlack),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '✅ AppOutlinedButton: 枠線ボタン',
                    style: TextStyle(color: AppColors.textBlack),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '✅ AppConfirmDialog: 確認ダイアログ',
                    style: TextStyle(color: AppColors.textBlack),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '✅ 各コンポーネントが適切に表示されています',
                    style: TextStyle(color: AppColors.textBlack),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
