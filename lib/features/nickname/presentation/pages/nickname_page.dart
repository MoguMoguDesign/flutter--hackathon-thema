import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:flutterhackthema/app/app_di/nickname_provider.dart';
import '../../../../shared/shared.dart';
import '../../../../shared/presentation/widgets/inputs/app_text_field.dart';

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
                label: '決定して次の行へ',
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
