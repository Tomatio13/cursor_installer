<h1 align="center">🧙 Cursor Setup Wizard - TUI版</h1>

<p align="center">
    <img src="https://img.shields.io/badge/Ubuntu-22.04+-orange?style=for-the-badge&logo=ubuntu" alt="Ubuntu 22.04+"/>
    <img src="https://img.shields.io/badge/Bash-Script-green?style=for-the-badge&logo=gnu-bash" alt="Bash Script"/>
    <img src="https://img.shields.io/badge/TUI-Interactive-purple?style=for-the-badge" alt="TUI"/>
    <img src="https://img.shields.io/badge/AppImage-Installer-blue?style=for-the-badge" alt="AppImage"/>
</p>

<p align="center">
    <a href="README_JP.md"><img src="https://img.shields.io/badge/ドキュメント-日本語-white.svg" alt="JA doc"/></a>
    <a href="README.md"><img src="https://img.shields.io/badge/english-document-white.svg" alt="EN doc"></a>
</p>

<p align="center">
    <strong>🎯 美しいTUI（Terminal User Interface）でCursor AIエディタを簡単インストール</strong><br>
    Ubuntu系システム向けの対話型インストールウィザード
</p>

<div align="center">
    <img src="image/install_movie.gif" alt="Cursor Setup Wizard Demo" width="800"/>
    <br>
    <em>🎬 TUIウィザードのデモ動画</em>
</div>

## ✨ 新機能 - TUIインターフェース

🎨 **美しい対話型インターフェース**
- 📋 直感的なメニューシステム
- ⚡ ステップバイステップの進行表示
- 🎯 リアルタイムプログレスインジケーター
- 🎪 カラフルなメッセージとアイコン表示
- 🔄 スピナーアニメーション付きの処理状況表示

## 🚀 クイックスタート

### ワンライナーインストール
```bash
bash <(curl -s https://raw.githubusercontent.com/your-repo/cursor_installer/main/quick_install.sh)
```

### 手動ダウンロード & 実行
```bash
# スクリプトをダウンロード
curl -O https://raw.githubusercontent.com/your-repo/cursor_installer/main/install_cursor_to_ubuntu.sh

# 実行権限を付与
chmod +x install_cursor_to_ubuntu.sh

# TUIウィザードを起動
./install_cursor_to_ubuntu.sh
```

## 🎛️ メインメニュー

TUIウィザードでは以下のオプションを選択できます：

| オプション | 説明 |
|-----------|------|
| 🚀 **完全インストール (推奨)** | 最新版を自動ダウンロード・完全セットアップ |
| 🔧 **既存インストールの再設定** | 設定ファイルとランチャーを再構築 |
| ⚙️ **CLIコマンドの追加** | `cursor` コマンドのみを追加/更新 |
| ℹ️ **バージョン情報の確認** | 現在と最新バージョンを比較表示 |
| 🚪 **終了** | ウィザードを終了 |

## 📊 インストールプロセス

TUIウィザードは以下の8ステップで処理を実行します：

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

各ステップでリアルタイムの進行状況とスピナーアニメーションが表示されます。

## ✨ 主要機能

### 🎯 自動化機能
- **🔄 最新版を自動取得** - GitHubから最新のAppImageを自動検出
- **📥 スマートダウンロード** - 既存バージョンをチェックして必要時のみダウンロード
- **🗂️ バージョン管理** - 最大3つのバージョンを自動保持
- **🧹 自動クリーンアップ** - 古いバージョンを自動削除

### 🎨 ユーザーエクスペリエンス
- **🎪 カラフルな表示** - 成功/エラー/情報メッセージを色分け表示
- **⚡ プログレス表示** - 各処理の進行状況をリアルタイム表示
- **🔄 インタラクティブメニュー** - gumライブラリによる美しいTUI
- **📝 詳細ログ** - 処理内容を詳細に記録

### 🛠️ 技術機能
- **🔧 依存関係自動解決** - gumライブラリを自動インストール
- **🛡️ エラーハンドリング** - 包括的なエラー処理とフォールバック
- **⚙️ 設定管理** - インストール情報を設定ファイルに保存
- **🔒 セキュリティ** - ユーザーローカルインストール（sudo不要）

## 📁 インストール内容

### 📂 ファイル構成
```
~/Applications/cursor/           # メインアプリケーションディレクトリ
├── images/                      # AppImageファイル保存場所
├── squashfs-root/              # 展開されたアプリケーション
└── ...

~/.local/bin/cursor             # コマンドライン実行スクリプト
~/.local/share/applications/cursor.desktop  # デスクトップランチャー
~/.local/share/icons/cursor.png # アプリケーションアイコン
~/.local/share/cursor/cursor.log # アプリケーションログ
~/.config/cursor-setup/config   # インストール設定ファイル
```

## 🎯 使用方法

インストール後、以下の方法でCursorを起動できます：

### 🖱️ GUI起動
- アプリケーションメニューから「Cursor」を検索
- デスクトップランチャーをクリック

### ⌨️ コマンドライン起動
```bash
# 通常起動
cursor

# バージョン確認
cursor --version

# ファイルを指定して起動
cursor /path/to/your/project
```

## 📋 システム要件

### 🐧 対応OS
- **Ubuntu 22.04+**
- **Pop!_OS 22.04+**
- **Linux Mint 21+**
- **その他Ubuntu系ディストリビューション**

### 🛠️ 必要なツール
- **curl** - ダウンロード用
- **bash 4.0+** - スクリプト実行用
- **インターネット接続** - ダウンロードとgumインストール用

### 📦 自動インストールされる依存関係
- **gum** - TUIライブラリ（自動インストール）

## ⚙️ 高度な使用方法

### 🔧 設定ファイル
インストール情報は `~/.config/cursor-setup/config` に保存されます：
```bash
# Cursor Setup Wizard Configuration
LAST_INSTALLED_VERSION=1.1.5
INSTALLATION_DATE=2024-01-15 14:30:22
DOWNLOAD_URL=https://downloads.cursor.com/production/.../Cursor-1.1.5-x86_64.AppImage
```

### 🗂️ ログファイル
アプリケーションの実行ログは `~/.local/share/cursor/cursor.log` に記録されます。

### 🔄 再インストール
既存のインストールがある場合、ウィザードが自動検出して適切な選択肢を提示します。

## 🔍 トラブルシューティング

### ❓ よくある問題

**Q: gumが見つからないエラーが出る**
A: スクリプトが自動的にgumをインストールします。sudo権限が必要です。

**Q: Cursorが起動しない**
A: 「既存インストールの再設定」オプションを試してください。

**Q: 古いバージョンが残っている**
A: スクリプトは自動的に古いバージョンをクリーンアップします（最大3つまで保持）。

**Q: デスクトップにアイコンが表示されない**
A: デスクトップデータベースの更新に時間がかかる場合があります。ログアウト/ログインを試してください。

## 🤝 貢献

このプロジェクトへの貢献を歓迎します！

### 🛠️ 開発環境
```bash
# リポジトリをクローン
git clone https://github.com/your-repo/cursor_installer.git
cd cursor_installer

# スクリプトをテスト実行
./install_cursor_to_ubuntu.sh
```

### 📝 バグレポート・機能要望
Issues タブからお気軽にご報告ください。

## 📄 ライセンス

このプロジェクトはMITライセンスの下で公開されています。

## 🙏 謝辞

- [Cursor AI](https://cursor.sh/) - 素晴らしいAIエディタの提供
- [oslook/cursor-ai-downloads](https://github.com/oslook/cursor-ai-downloads) - ダウンロードリンク情報の提供
- [Charm](https://charm.sh/) - 美しいTUIライブラリ「gum」の提供
- [jorcelinojunior/cursor-setup-wizard](https://github.com/jorcelinojunior/cursor-setup-wizard) - TUIデザインのインスピレーション

---

<p align="center">
    <strong>🧙 Cursor Setup Wizard で快適なAI開発環境を構築しましょう！</strong>
</p> 