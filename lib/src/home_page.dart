import 'package:flutter/material.dart';
import 'package:flutterhackthema/base_ui.dart';

/// アプリのホームページ。
///
/// 2つのコンポーネントテストページへの遷移ボタンを表示する。
class HomePage extends StatelessWidget {
  /// [HomePage] のコンストラクタ。
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Component Test App'),
        backgroundColor: AppColors.adminPrimary,
        foregroundColor: AppColors.white,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.gradientDarkBlue,
              AppColors.gradientBlack,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'コンポーネントテスト',
                  style: AppTextStyles.headlineLarge.copyWith(
                    fontSize: 28,
                    color: AppColors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  'テストしたいコンポーネント集を選択してください',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.white70,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 64),

                // TCG Match Manager ボタン
                CommonConfirmButton(
                  text: 'TCG Match Manager',
                  style: ConfirmButtonStyle.userFilled,
                  onPressed: () {
                    Navigator.of(context).pushNamed('/tcg-components');
                  },
                ),
                const SizedBox(height: 24),

                // My Gourmet ボタン
                CommonConfirmButton(
                  text: 'My Gourmet',
                  style: ConfirmButtonStyle.adminFilled,
                  onPressed: () {
                    Navigator.of(context).pushNamed('/gourmet-components');
                  },
                ),

                const SizedBox(height: 48),

                // 説明テキスト
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.white.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        '各ボタンをタップすると、',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.white70,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'それぞれのプロジェクトのUIコンポーネントを',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.white70,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'テストできます',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.white70,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
