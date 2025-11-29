# Flutter Hackathon Thema Makefile
# 三層アーキテクチャFlutter開発環境のセットアップと各種コマンドのショートカット

# =============================================================================
# 環境変数設定
# =============================================================================

# 環境変数ファイル
ENV_FILE := .env

# .envファイルが存在する場合は読み込む
ifneq (,$(wildcard $(ENV_FILE)))
    include $(ENV_FILE)
    export
endif

.PHONY: help
help: ## このヘルプメッセージを表示
	@echo "Flutter Hackathon Thema Makefile コマンド一覧:"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

# =============================================================================
# セットアップコマンド
# =============================================================================

.PHONY: setup-macos setup-windows setup-fvm-macos setup-fvm-windows setup-lcov-macos

setup-macos: ## macOS環境のセットアップ（FVM + lcov）
	${MAKE} setup-fvm-macos
	${MAKE} setup-lcov-macos
	${MAKE} get
	@echo "✅ macOS環境のセットアップが完了しました"
	@echo "次のコマンドを実行してください: make generate"

setup-windows: ## Windows環境のセットアップ（FVM）
	${MAKE} setup-fvm-windows
	${MAKE} get
	@echo "✅ Windows環境のセットアップが完了しました"
	@echo "次のコマンドを実行してください: make generate"

setup-fvm-macos: ## FVMをmacOSにインストール
	brew tap leoafarias/fvm
	brew install fvm
	fvm install
	fvm use

setup-fvm-windows: ## FVMをWindowsにインストール
	choco install fvm
	fvm install
	fvm use

setup-lcov-macos: ## lcov（カバレッジツール）をインストール
	brew install lcov

.PHONY: upgrade-flutter
upgrade-flutter: ## Flutterを最新バージョンにアップグレード
	fvm flutter upgrade
	fvm install

# =============================================================================
# 依存関係管理
# =============================================================================

.PHONY: get clean-get

get: ## 依存関係をインストール
	fvm flutter pub get

clean-get: ## クリーン後に依存関係を再インストール
	fvm flutter clean
	fvm flutter pub get

# =============================================================================
# コード生成
# =============================================================================

.PHONY: generate watch-generate

generate: ## コード生成を実行（freezed、json_serializable、riverpod）
	fvm flutter pub run build_runner build --delete-conflicting-outputs
	@echo "✅ コード生成が完了しました"

watch-generate: ## コード生成をwatchモードで実行（開発時推奨）
	fvm flutter pub run build_runner watch --delete-conflicting-outputs

# =============================================================================
# コード品質チェック
# =============================================================================

.PHONY: check analyze format format-fix lint

check: analyze format test ## 全ての品質チェックを実行（analyze + format + test）
	@echo "✅ 全ての品質チェックが完了しました"

analyze: ## 静的解析を実行（very_good_analysis + riverpod_lint）
	fvm flutter analyze

format: ## コードフォーマットをチェック
	fvm dart format --set-exit-if-changed .

format-fix: ## コードフォーマットを適用
	fvm dart format .

lint: analyze ## 静的解析を実行（analyzeのエイリアス）

# =============================================================================
# テスト
# =============================================================================

.PHONY: test test-file coverage coverage-report coverage-html

test: ## 全てのテストを実行
	fvm flutter test

test-file: ## 特定のテストファイルを実行（例: make test-file FILE=test/features/auth/auth_test.dart）
	@if [ -z "$(FILE)" ]; then \
		echo "エラー: FILEパラメータを指定してください"; \
		echo "例: make test-file FILE=test/features/auth/auth_test.dart"; \
		exit 1; \
	fi
	fvm flutter test $(FILE)

coverage: ## カバレッジ付きでテストを実行
	fvm flutter test --coverage

coverage-report: coverage ## カバレッジレポートを生成して表示（自動生成ファイル除外）
	@echo "📂 Filtering out generated files from coverage..."
	@lcov --remove coverage/lcov.info \
		'**/*.g.dart' \
		'**/*.freezed.dart' \
		'**/*.mocks.dart' \
		--ignore-errors unused \
		-o coverage/lcov.info > /dev/null 2>&1
	@echo "📊 Test Coverage Summary:"
	@lcov --summary coverage/lcov.info
	@echo ""
	@echo "💡 Note: Auto-generated files (.g.dart, .freezed.dart, .mocks.dart) are excluded"

coverage-html: coverage ## HTMLカバレッジレポートを生成（自動生成ファイル除外）
	@lcov --remove coverage/lcov.info \
		'**/*.g.dart' \
		'**/*.freezed.dart' \
		'**/*.mocks.dart' \
		--ignore-errors unused \
		-o coverage/lcov_filtered.info > /dev/null 2>&1
	@genhtml coverage/lcov_filtered.info -o coverage/html > /dev/null 2>&1
	@echo "✅ カバレッジレポート: coverage/html/index.html"
	@echo "💡 Note: 自動生成ファイル（*.g.dart, *.freezed.dart, *.mocks.dart）は除外されています"
	@open coverage/html/index.html || true

# =============================================================================
# ビルド・実行コマンド
# =============================================================================

.PHONY: run build-android build-ios build-web

run: ## アプリを起動（開発環境）
	fvm flutter run

# Android APKビルド
build-android: ## Android用APKをビルド
	fvm flutter build apk

build-android-release: ## Android用リリースAPKをビルド
	fvm flutter build apk --release

# iOSビルド
build-ios: ## iOS用アプリをビルド
	fvm flutter build ios

build-ios-release: ## iOS用リリースアプリをビルド
	fvm flutter build ios --release

# Webビルド
build-web: ## Web用アプリをビルド
	fvm flutter build web

build-web-release: ## Web用リリースアプリをビルド
	fvm flutter build web --release --web-renderer canvaskit

# 環境変数付きビルド・実行コマンド
build-web-env: ## Web用アプリをビルド（環境変数付き）
	fvm flutter build web --dart-define=GEMINI_API_KEY=$(GEMINI_API_KEY)

build-web-release-env: ## Web用リリースアプリをビルド（環境変数付き）
	fvm flutter build web --release --web-renderer canvaskit --dart-define=GEMINI_API_KEY=$(GEMINI_API_KEY)

run-env: ## 環境変数付きでアプリを起動
	fvm flutter run --dart-define=GEMINI_API_KEY=$(GEMINI_API_KEY)

# デプロイ
deploy-preview: build-web-release ## ローカルでWebビルドをプレビュー
	@echo "🌐 Opening preview at http://localhost:8000"
	@cd build/web && python3 -m http.server 8000

# =============================================================================
# クリーンアップ
# =============================================================================

.PHONY: clean deep-clean

clean: ## ビルド成果物をクリーンアップ
	fvm flutter clean

deep-clean: clean ## 完全クリーンアップ（依存関係も削除）
	rm -rf .dart_tool
	rm -rf .flutter-plugins
	rm -rf .flutter-plugins-dependencies
	rm -rf build
	rm -rf ios/Pods
	rm -rf ios/.symlinks
	rm -rf android/.gradle
	rm -rf coverage
	@echo "✅ 完全クリーンアップが完了しました"

# =============================================================================
# 開発ワークフロー（4フェーズ）
# =============================================================================

.PHONY: pre-commit pre-push full-check quality-gate

pre-commit: format-fix analyze ## プレコミットチェック（format + analyze）
	@echo "✅ プレコミットチェックが完了しました"

pre-push: check ## プレプッシュチェック（format + analyze + test）
	@echo "✅ プレプッシュチェックが完了しました"

quality-gate: clean-get generate check coverage ## 品質ゲート（全チェック + カバレッジ）
	@echo "✅ 品質ゲートチェックが完了しました"

full-check: clean-get generate check coverage ## 完全チェック（quality-gateのエイリアス）
	@echo "✅ 完全チェックが完了しました"

# IMPLEMENTフェーズで実行すべきコマンド
implement-check: generate analyze format test ## IMPLEMENTフェーズの必須チェック
	@echo "✅ IMPLEMENT フェーズのチェックが完了しました"
	@echo "次のステップ: コミット作成（/commit または make commit-guide）"

# =============================================================================
# Git ワークフロー
# =============================================================================

.PHONY: branch-status commit-guide

branch-status: ## 現在のブランチとGitステータスを表示
	@echo "📌 Current Branch:"
	@git branch --show-current
	@echo ""
	@echo "📝 Git Status:"
	@git status -s

commit-guide: ## Angularスタイルのコミットメッセージガイドを表示
	@echo "📝 Angular Style Commit Message Format:"
	@echo ""
	@echo "  feat(scope): 新機能の追加"
	@echo "  fix(scope): バグ修正"
	@echo "  docs(scope): ドキュメント更新"
	@echo "  style(scope): コードスタイル変更（機能影響なし）"
	@echo "  refactor(scope): リファクタリング"
	@echo "  test(scope): テスト追加・修正"
	@echo "  chore(scope): ビルドプロセスやツールの変更"
	@echo ""
	@echo "例:"
	@echo "  git commit -m 'feat(auth): ログイン機能を追加'"
	@echo "  git commit -m 'fix(profile): ユーザー名表示のバグを修正'"
	@echo "  git commit -m 'docs: README を更新'"
	@echo ""
	@echo "💡 Tip: /commit コマンドを使用すると自動的に適切な形式でコミットできます"

# =============================================================================
# アーキテクチャ検証
# =============================================================================

.PHONY: arch-check

arch-check: ## 三層アーキテクチャの依存関係をチェック
	@echo "🏗️  Three-Layer Architecture Dependency Check"
	@echo ""
	@echo "Checking for forbidden Feature → Feature dependencies..."
	@if grep -r "import 'package:flutterhackthema/features/" lib/features/ --include="*.dart" | grep -v "\.g\.dart" | grep -v "\.freezed\.dart" | grep -v "\.mocks\.dart"; then \
		echo "❌ Found forbidden Feature → Feature dependencies!"; \
		echo "Features must only depend on Shared layer."; \
		exit 1; \
	else \
		echo "✅ No forbidden Feature → Feature dependencies found"; \
	fi
	@echo ""
	@echo "Checking for forbidden Shared → Feature/App dependencies..."
	@if grep -r "import 'package:flutterhackthema/features/\|import 'package:flutterhackthema/app/" lib/shared/ --include="*.dart" | grep -v "\.g\.dart" | grep -v "\.freezed\.dart"; then \
		echo "❌ Found forbidden Shared → Feature/App dependencies!"; \
		echo "Shared layer must be completely independent."; \
		exit 1; \
	else \
		echo "✅ No forbidden Shared → Feature/App dependencies found"; \
	fi
	@echo ""
	@echo "✅ Architecture dependency check passed!"

# =============================================================================
# ドキュメント・情報表示
# =============================================================================

.PHONY: doctor info workflow

doctor: ## Flutter環境の診断
	fvm flutter doctor -v

info: ## プロジェクト情報を表示
	@echo "📦 Flutter Hackathon Thema Project Info"
	@echo ""
	@echo "🏗️  Architecture: Three-Layer (App → Feature → Shared)"
	@echo "📱 Flutter: $(shell fvm flutter --version | head -n 1)"
	@echo "🎯 Dart: $(shell fvm dart --version)"
	@echo "📦 FVM: $(shell fvm --version)"
	@echo ""
	@echo "🔧 Tech Stack:"
	@echo "  - hooks_riverpod: 3.x (State Management)"
	@echo "  - go_router: 16.x (Routing)"
	@echo "  - freezed: 3.x (Immutable Models)"
	@echo "  - build_runner: Code Generation"
	@echo ""
	@echo "📚 Documentation:"
	@echo "  - CLAUDE.md: Claude Code guidance"
	@echo "  - docs/ARCHITECTURE.md: Architecture details"
	@echo "  - docs/STYLE_GUIDE.md: Coding standards"
	@echo ""
	@echo "🎯 Quick Start:"
	@echo "  make get          # Install dependencies"
	@echo "  make generate     # Generate code"
	@echo "  make run          # Run the app"

workflow: ## 4フェーズ開発ワークフローガイドを表示
	@echo "🔄 4-Phase Development Workflow"
	@echo ""
	@echo "1️⃣  INVESTIGATE Phase (/investigate)"
	@echo "   Purpose: Understand requirements and constraints"
	@echo "   Output: docs/investigate/investigate_{TIMESTAMP}.md"
	@echo ""
	@echo "2️⃣  PLAN Phase (/plan)"
	@echo "   Purpose: Create detailed implementation strategy"
	@echo "   Output: docs/plan/plan_{TIMESTAMP}.md"
	@echo ""
	@echo "3️⃣  IMPLEMENT Phase (/implement)"
	@echo "   Purpose: Execute the plan with high-quality code"
	@echo "   Commands: make implement-check"
	@echo "   Output: docs/implement/implement_{TIMESTAMP}.md + Draft PR"
	@echo ""
	@echo "4️⃣  TEST Phase (/test)"
	@echo "   Purpose: Comprehensive quality verification"
	@echo "   Commands: make test, make coverage"
	@echo "   Output: docs/test/test_{TIMESTAMP}.md"
	@echo ""
	@echo "💡 Tip: Use Claude Code slash commands for each phase"

# =============================================================================
# 開発者向けクイックコマンド
# =============================================================================

.PHONY: dev start watch

dev: get generate watch-generate ## 開発環境の起動（依存関係インストール + watch モード）

start: run ## アプリを起動（runのエイリアス）

watch: watch-generate ## コード生成のwatchモード（watch-generateのエイリアス）

# =============================================================================
# CI/CD用コマンド
# =============================================================================

.PHONY: ci-check ci-test

ci-check: get generate analyze format ## CI環境での品質チェック
	@echo "✅ CI品質チェックが完了しました"

ci-test: get generate test ## CI環境でのテスト実行
	@echo "✅ CIテストが完了しました"

# =============================================================================
# デフォルトターゲット
# =============================================================================

.DEFAULT_GOAL := help
