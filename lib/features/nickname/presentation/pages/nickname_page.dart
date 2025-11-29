import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutterhackthema/app/app_di/nickname_provider.dart';
import 'package:flutterhackthema/shared/presentation/widgets/buttons/primary_button.dart';
import 'package:flutterhackthema/shared/presentation/widgets/inputs/app_text_field.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Spacer(flex: 2),
              // サービス名ロゴエリア
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    'サービス名',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              // ニックネーム入力フィールド
              AppTextField(
                controller: nicknameController,
                label: 'ニックネーム',
                hintText: 'ニックネームを入力',
                maxLength: 20,
              ),
              const SizedBox(height: 24),
              // 決定ボタン
              PrimaryButton(
                text: '決定して次の行へ',
                onPressed: isValid.value
                    ? () {
                        // ニックネームをProviderに保存
                        ref
                            .read(temporaryNicknameProvider.notifier)
                            .setNickname(nicknameController.text.trim());
                        // 投稿一覧画面へ遷移
                        context.go('/posts');
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
