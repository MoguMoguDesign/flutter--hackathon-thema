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
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../app/app_router/routes.dart';
import '../../../../shared/shared.dart';
import '../../../../shared/presentation/widgets/inputs/app_text_field.dart';
import '../providers/nickname_provider.dart';

/// ニックネーム入力画面。
///
/// ユーザー識別用のニックネームを取得する初期画面。
/// ワイヤーフレーム: `ニックネーム入力.png`
class NicknamePage extends HookConsumerWidget {
  /// ニックネーム入力画面を作成する。
  const NicknamePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nicknameController = useTextEditingController();
    final isValid = useState(false);

    useEffect(() {
      void listener() {
        final text = nicknameController.text.trim();
        isValid.value = text.isNotEmpty && text.length <= 20;
      }

      nicknameController.addListener(listener);
      return () => nicknameController.removeListener(listener);
    }, [nicknameController]);

    return AppScaffoldWithBackground(
      backgroundImage: 'assets/images/start_background.png',
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              // サービス名ロゴエリア
              SvgPicture.asset(
                'assets/images/logo.svg',
                width: 200,
                height: 100,
                fit: BoxFit.contain,
              ),
              const Spacer(flex: 1),
              // ニックネーム入力フィールド
              AppTextField(
                controller: nicknameController,
                label: 'ニックネーム',
                hintText: 'ニックネームを入力',
                maxLength: 20,
              ),
              const SizedBox(height: 24),
              // 決定ボタン
              AppFilledButton(
                label: 'はじめる',
                onPressed: isValid.value
                    ? () async {
                        try {
                          debugPrint(
                            'ニックネーム保存開始: ${nicknameController.text.trim()}',
                          );

                          // ニックネームをProviderに保存（永続化）
                          await ref
                              .read(nicknameProvider.notifier)
                              .setNickname(nicknameController.text.trim());

                          debugPrint('ニックネーム保存完了');

                          // 俳句一覧画面へ遷移
                          if (context.mounted) {
                            debugPrint('遷移開始: /posts');
                            const HaikuListRoute().go(context);
                          } else {
                            debugPrint('context.mounted = false');
                          }
                        } catch (e, stackTrace) {
                          debugPrint('エラー発生: $e');
                          debugPrint('スタックトレース: $stackTrace');

                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('エラーが発生しました: $e'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        }
                      }
                    : null,
              ),
              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }
}
