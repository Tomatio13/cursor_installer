<h1 align="center">🖥️ Ubuntu用 Cursor AI エディタ インストーラー</h1>

<p align="center">
    <img src="https://img.shields.io/badge/Ubuntu-22.04+-orange?style=for-the-badge&logo=ubuntu" alt="Ubuntu 22.04+"/>
    <img src="https://img.shields.io/badge/Bash-Script-green?style=for-the-badge&logo=gnu-bash" alt="Bash Script"/>
    <img src="https://img.shields.io/badge/AppImage-Installer-blue?style=for-the-badge" alt="AppImage"/>
</p>

<p align="center">
    <a href="README_JP.md"><img src="https://img.shields.io/badge/ドキュメント-日本語-white.svg" alt="JA doc"/></a>
    <a href="README.md"><img src="https://img.shields.io/badge/english-document-white.svg" alt="EN doc"></a>
</p>

<p align="center">
    UbuntuシステムにCursor AIエディタを自動インストールするbashスクリプトです。
</p>

## ✨ 機能

このインストールスクリプトは以下を実行します：
- **🔄 最新版を自動取得** - GitHubからCursor AI エディタのAppImageを自動取得
- **📥 ダウンロードと展開** - AppImageをホームディレクトリにダウンロード・展開
- **🖥️ デスクトップ統合** - アプリケーションメニューへのエントリ作成
- **⚡ コマンドライン起動設定** - ターミナルからの起動スクリプト作成
- **📦 複数バージョン管理** - 最大3つのバージョンを保持
- **🆕 常に最新版をインストール** - 利用可能な最新バージョンを自動インストール

## 🚀 インストール方法

1. **スクリプトに実行権限を付与:**
```bash
chmod +x install_cursor_to_ubuntu.sh
```

2. **インストーラーを実行:**
```bash
./install_cursor_to_ubuntu.sh
```

## 📁 インストール内容

- **📂 アプリケーションファイル**: `~/Applications/cursor/`
- **🖥️ デスクトップランチャー**: `~/.local/share/applications/cursor.desktop`
- **⚡ コマンドラインスクリプト**: `~/.local/bin/cursor`
- **🎨 アプリケーションアイコン**: `~/.local/share/icons/cursor.png`
- **📝 ログファイル**: `~/.local/share/cursor/cursor.log`

## 🎯 使用方法

インストール後、以下の方法で使用できます：
- **🖱️ アプリケーションメニューから起動** (「Cursor」で検索)
- **⌨️ コマンドラインから実行**: `cursor`
- **ℹ️ バージョン確認**: `cursor --version`

## 📋 必要条件

- **🐧 Ubuntu 22.04+** (または互換Linuxディストリビューション)
- **🌐 curl** (ダウンロードと最新バージョン情報取得用)
- **📡 インターネット接続**

## ⚙️ 動作原理

スクリプトは以下を動的に実行します：
1. **📡 最新情報を取得** - [oslook/cursor-ai-downloads](https://github.com/oslook/cursor-ai-downloads) GitHubリポジトリから最新ダウンロード情報を取得
2. **🔍 URL抽出** - 最新のLinux x64 AppImageダウンロードURLを抽出
3. **📥 自動ダウンロード・インストール** - 最新バージョンを自動でダウンロード・インストール
4. **🔄 フォールバック** - GitHubが利用できない場合は既知の動作バージョンにフォールバック

## 📝 注意事項

- **🆕 常に最新版をインストール** (ハードコードされたバージョンではありません)
- **👤 ユーザーローカルインストール** (sudo不要)
- **🔄 デスクトップデータベース更新を自動処理**
- **🔇 不要なAppImageランタイムメッセージをフィルタリング**
- **🛡️ エラーハンドリングとフォールバック機能を内蔵** 