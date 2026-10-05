# LaTeX Drill

公式資料を読み、対応する小さな課題を解き、コンパイルと課題条件の確認で自分で進捗を確かめる LaTeX 練習ドリルです。採点者を置かず、エラーごとのヒントから次の一手を探せるようにします。

## 3つのトラック

各トラックに3問ずつ、合計9問を収録しています。

| トラック | 内容 | 主な公式資料 |
| --- | --- | --- |
| 初級 | 文書構造、論理構造、リスト、基本数式 | [Learn LaTeX 日本語版](https://www.learnlatex.org/ja/) |
| 中級 | 図表、相互参照、引用と参考文献 | [Learn LaTeX 日本語版](https://www.learnlatex.org/ja/)、[amsmath ユーザーガイド](https://www.latex-project.org/help/documentation/amsldoc_jpn.pdf) |
| 上級 | コマンドと環境、独自パッケージ、expl3 | [LaTeX Project 文書一覧](https://www.latex-project.org/help/documentation/) |

各課題の読み物は公式資料の該当箇所と対応しています。公式文書の内容をそのまま写すのではなく、練習に必要な概念を日本語で説明し、参照先を各章に記しています。

## 必要な環境

- Python 3.9 以降
- Windows では `py -3` または `python` コマンド
- TeX Live に含まれる `uplatex` と `dvipdfmx`
- TeX Live の `jlreq` クラス、`plautopatch`、`booktabs`、`everyhook`

この教材は `upLaTeX + dvipdfmx` を標準にしています。手元の既存LaTeX環境に合わせた設定です。Pythonの追加パッケージは使いません。
TeX Live は Linux と Windows をサポートしています。導入手順は [TeX Live公式ガイド](https://tug.org/texlive/doc/texlive-en/texlive-en.html) を参照してください。

## インストール

### Ubuntu / WSL

```bash
git clone https://github.com/Nyanziba/latex-drill.git
cd latex-drill
./install.sh
```

`install.sh` は Python、TeX Liveの実行ファイル、必要なLaTeXパッケージを確認します。Ubuntu / WSLで不足している場合は、確認後に次のAPTパッケージをインストールします。

```bash
sudo apt-get update
sudo apt-get install --no-install-recommends texlive-lang-japanese texlive-latex-recommended texlive-latex-extra
```

Ubuntu 24.04では `texlive-lang-japanese` に `uplatex`、`jlreq`、`plautopatch`、`texlive-latex-recommended` に `booktabs`、`texlive-latex-extra` に `everyhook` が含まれます（[日本語パッケージ](https://packages.ubuntu.com/noble/all/texlive-lang-japanese/filelist)、[推奨LaTeXパッケージ](https://packages.ubuntu.com/fr/noble/all/texlive-latex-recommended/filelist)、[追加LaTeXパッケージ](https://packages.ubuntu.com/noble/all/texlive-latex-extra/filelist)）。ほかのLinuxディストリビューションでは、TeX Liveと `uplatex`、`dvipdfmx`、`jlreq`、`plautopatch`、`booktabs`、`everyhook` を先にインストールしてください。

### Windows

1. [Python公式サイト](https://www.python.org/downloads/windows/)から Python 3.9 以降をインストールします。`py -3` ランチャーも利用できるようにしてください。
2. [TeX Live公式のWindowsインストーラー](https://tug.org/texlive/windows.html)でTeX Liveをインストールします。`uplatex`、`dvipdfmx`、`jlreq`、`plautopatch`、`booktabs`、`everyhook` が使える構成にしてください。
3. PowerShellでリポジトリのディレクトリに移動し、課題一覧を表示します。

```powershell
.\drill.bat list
```

TeX Liveの実行ファイルにPATHが通っているか、PowerShellで次を実行して確認できます。

```powershell
Get-Command uplatex, dvipdfmx, kpsewhich
kpsewhich jlreq.cls
kpsewhich plautopatch.sty
kpsewhich booktabs.sty
kpsewhich everyhook.sty
```

不足している場合は、[TeX Live Manager](https://tug.org/texlive/tlmgr.html)で次のコレクションを追加します（共有インストールでは管理者権限が必要なことがあります）。

```powershell
tlmgr install collection-langjapanese collection-latexrecommended collection-latexextra
```

## はじめかた

Linux / WSL:

```bash
./drill list
./drill read b01
./drill watch b01
```

Windows PowerShell:

```powershell
.\drill.bat list
.\drill.bat read b01
.\drill.bat watch b01
```

どちらのOSでも、以降のコマンド例にある `./drill` はWindowsでは `.\drill.bat` に置き換えられます。Pythonから直接実行する場合は、Linuxで `python3 drill list`、Windowsで `py -3 drill list` を使います。

課題ファイルの `% TODO` を埋めて保存すると、自動で課題条件とコンパイルを確認します。成功したら `% I AM NOT DONE` を削除してください。

## コマンド

| コマンド | 説明 |
| --- | --- |
| `./drill list` | 課題と完了状況を表示 |
| `./drill read [ID]` | 課題に対応する読み物を表示 |
| `./drill run [ID]` | 課題条件を確認してコンパイル |
| `./drill watch [ID]` | 保存後に自動で再確認 |
| `./drill hint ID` | ヒントを表示 |
| `./drill doc ID` | 公式資料のURLを表示 |
| `./drill solution ID` | 解答例を表示 |
| `./drill reset ID` | 課題を初期状態に戻す |
| `./drill verify` | 全課題を順に確認 |
| `./drill clean` | コンパイル生成物を削除 |

IDは `b01` のような課題IDか、一意に決まる部分文字列を使えます。初期化した課題に戻すには、Linuxで `./drill reset b01`、Windowsで `.\drill.bat reset b01` を実行します。resetは課題ディレクトリ内の変更を初期状態で置き換えます。
各コンパイルの出力は個別の `.build/<ID>/run-<番号>/` に保存されます。PDFを開いたままでも次の課題実行ができ、不要になった生成物は `./drill clean` で消せます。

## 採点の考え方

ランナーは課題ごとに指定したLaTeXの記述を確認し、upLaTeXで2回組版したあと `dvipdfmx` でPDFを作ります。相互参照などは生成された `.aux` ファイルも確認できます。具体的な失敗箇所に応じて課題別ヒントを表示します。

自動判定は課題の構造とコンパイルを確認します。組版の見た目や読みやすさの確認は、生成されたPDFを開いて自分で行ってください。

## 公式資料の範囲

初級は LaTeX Project が初心者向けコースとして案内している Learn LaTeX 日本語版を軸にし、日本語エンジンと和文用文書クラスの追加レッスンも取り上げます。中級は AMS の `amsmath` ガイドを含む利用者向け資料、上級は LaTeX Project Team の著者・クラス・パッケージ開発者向け資料を参照します。上級トラックは一般の文書作成入門とは対象が異なります。
