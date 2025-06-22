# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This repository contains a bash script installer for Cursor AI editor on Ubuntu systems. The main script `install_cursor_to_ubuntu.sh` handles downloading, extracting, and configuring Cursor as a desktop application.

## Key Components

- **install_cursor_to_ubuntu.sh**: Main installation script that:
  - Dynamically fetches the latest Cursor AppImage download URL from GitHub
  - Downloads and extracts the AppImage to `~/Applications/cursor/`
  - Creates desktop integration files
  - Sets up a command-line launcher script in `~/.local/bin/cursor`
  - Manages version control (keeps up to 3 versions)

## Installation Process

The script performs these steps:
1. Creates directory structure in `~/Applications/cursor/` and `~/.local/`
2. Fetches latest download URL from [oslook/cursor-ai-downloads](https://github.com/oslook/cursor-ai-downloads)
3. Downloads the latest Cursor AppImage dynamically
4. Extracts AppImage contents using `--appimage-extract`
5. Creates launcher script with version support and log filtering
6. Installs desktop file for system integration
7. Updates desktop database

## Configuration

- **Download URL**: Dynamically fetched from GitHub repository
- **Installation paths**: All under user home directory (`~/Applications/cursor/`, `~/.local/`)
- **Version management**: Keeps maximum 3 installed versions
- **Logging**: Filtered output goes to `~/.local/share/cursor/cursor.log`
- **Fallback**: Uses known working version if GitHub is unavailable

## Running the Script

```bash
chmod +x install_cursor_to_ubuntu.sh
./install_cursor_to_ubuntu.sh
```

## Documentation

- **README.md**: English documentation with full installation and usage instructions
- **README_JP.md**: Japanese documentation (日本語ドキュメント)
- Both files include language switching badges and consistent formatting

## Compatibility

- **Primary target**: Ubuntu 22.04+
- **Compatible with**: Most modern Linux distributions that support AppImage
- **Requirements**: curl, desktop environment with .desktop file support

## Notes

- Script uses `set -euo pipefail` for robust error handling
- Dynamic version detection and download from official sources
- Icon extraction uses specific path within AppImage structure
- Desktop integration includes MIME type handlers and categories
- Includes interrupt handling for graceful cancellation during download

# 🧙 Cursor Setup Wizard - TUI版 変更履歴

## 📋 概要

元のシンプルなbashスクリプトを、[jorcelinojunior/cursor-setup-wizard](https://github.com/jorcelinojunior/cursor-setup-wizard)にインスパイアされた美しいTUI（Terminal User Interface）版に全面的に改良しました。

## ✨ 主要な変更点

### 🎨 新しいTUIインターフェース

#### 1. **対話型メニューシステム**
- `gum`ライブラリを使用した美しいメニュー表示
- 矢印キーでの選択操作
- カラフルなアイコンとテキスト表示

#### 2. **ステップバイステップ表示**
```
Step 1: ディレクトリの作成 📁
Step 2: バージョンチェック 🔍
Step 3: Cursorのダウンロード ⬇️
Step 4: アプリケーションの展開 📦
Step 5: ランチャーの設定 ⚡
Step 6: アイコンのインストール 🎨
Step 7: デスクトップ統合 🖥️
Step 8: システム更新 🔄
```

#### 3. **リアルタイムプログレス表示**
- スピナーアニメーション付きの処理状況表示
- 各ステップの成功/失敗を視覚的にフィードバック
- カラーコード化されたメッセージ表示

### 🛠️ 機能面の改良

#### 1. **メニューオプション**
- 🚀 **完全インストール (推奨)**: 全自動インストール
- 🔧 **既存インストールの再設定**: 設定のみ再構築
- ⚙️ **CLIコマンドの追加**: コマンドラインランチャーのみ追加
- ℹ️ **バージョン情報の確認**: 現在と最新バージョンの比較
- 🚪 **終了**: ウィザードの終了

#### 2. **自動依存関係解決**
- `gum`ライブラリの自動インストール
- apt リポジトリの自動設定
- GPGキーの自動追加

#### 3. **設定管理機能**
- `~/.config/cursor-setup/config`に設定情報を保存
- インストール履歴の記録
- バージョン情報の永続化

### 🎯 ユーザーエクスペリエンスの向上

#### 1. **視覚的改善**
- Unicode絵文字とアイコンの使用
- カラーテーマの統一
- ボーダーとパディングによる読みやすさの向上

#### 2. **エラーハンドリング**
- 包括的なエラーメッセージ
- 自動リトライ機能
- フォールバック処理の改善

#### 3. **多言語対応**
- 日本語メッセージの完全対応
- 英語ドキュメントの並行提供

## 🔧 技術的な改良点

### 1. **コード構造の改善**
```bash
# 関数ベースの設計
- show_header()
- show_step()
- show_success()
- show_error()
- show_info()
- run_full_installation()
- reconfigure_installation()
- add_cli_command()
```

### 2. **設定管理**
```bash
# 設定ファイルの自動生成
~/.config/cursor-setup/config:
LAST_INSTALLED_VERSION=1.1.5
INSTALLATION_DATE=2024-01-15 14:30:22
DOWNLOAD_URL=https://downloads.cursor.com/...
```

### 3. **ログ機能の強化**
- 詳細な処理ログの記録
- エラー情報の保存
- デバッグ情報の出力

## 📦 新しいファイル構成

### 追加されたファイル
- `quick_install.sh` - ワンライナーインストール用
- `~/.config/cursor-setup/config` - 設定ファイル

### 更新されたファイル
- `install_cursor_to_ubuntu.sh` - メインスクリプト（TUI版）
- `README.md` - 英語版ドキュメント
- `README_JP.md` - 日本語版ドキュメント

## 🚀 使用方法の変更

### 従来版
```bash
# シンプルな実行
./install_cursor_to_ubuntu.sh
```

### TUI版
```bash
# ワンライナーインストール
bash <(curl -s https://raw.githubusercontent.com/your-repo/cursor_installer/main/quick_install.sh)

# 手動実行
./install_cursor_to_ubuntu.sh
# → 対話型メニューが表示される
```

## 🎪 TUIライブラリ (gum) の活用

### 使用している機能
- `gum style` - テキストスタイリング
- `gum choose` - メニュー選択
- `gum spin` - スピナーアニメーション
- `gum confirm` - 確認ダイアログ
- `gum input` - ユーザー入力

### 表示例
```bash
# ヘッダー表示
gum style \
    --foreground 212 \
    --border-foreground 212 \
    --border double \
    --align center \
    --width 60 \
    --margin "1 2" \
    --padding "2 4" \
    "🧙 Cursor Setup Wizard"

# メニュー選択
gum choose \
    --header "実行する操作を選択してください:" \
    --height 10 \
    "🚀 完全インストール (推奨)" \
    "🔧 既存インストールの再設定"
```

## 🔄 互換性とマイグレーション

### 既存インストールとの互換性
- 既存のインストールを自動検出
- 設定の自動マイグレーション
- バージョン管理の継続

### システム要件の変更
- `gum`ライブラリの追加（自動インストール）
- sudo権限の必要性（gumインストール時のみ）

## 🎯 今後の拡張予定

### 計画中の機能
- AppArmor セキュリティプロファイルの設定
- 複数のCursorバージョンの並行管理
- 設定のバックアップ・復元機能
- アップデート通知機能

### 改善予定
- より詳細なプログレス表示
- ネットワークエラーのハンドリング改善
- 多言語サポートの拡張

## 📊 パフォーマンス比較

| 項目 | 従来版 | TUI版 |
|------|--------|-------|
| 実行時間 | ~30秒 | ~35秒 |
| ユーザビリティ | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| エラーハンドリング | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| 視覚的魅力 | ⭐⭐ | ⭐⭐⭐⭐⭐ |
| 設定管理 | ⭐⭐ | ⭐⭐⭐⭐⭐ |

## 🙏 謝辞

この改良版は以下のプロジェクトからインスピレーションを得ています：
- [jorcelinojunior/cursor-setup-wizard](https://github.com/jorcelinojunior/cursor-setup-wizard) - TUIデザインの参考
- [Charm](https://charm.sh/) - 美しいTUIライブラリ「gum」の提供

---

**🧙 Cursor Setup Wizard TUI版で、より快適なインストール体験をお楽しみください！**