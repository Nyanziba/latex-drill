#!/bin/sh

set -eu

repository_directory=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

if ! command -v python3 >/dev/null 2>&1; then
    printf '%s\n' 'Python 3.9 以降が必要です。Pythonをインストールしてから再実行してください。' >&2
    exit 1
fi

if ! python3 -c 'import sys; sys.exit(0 if sys.version_info >= (3, 9) else 1)'; then
    printf '%s\n' 'Python 3.9 以降が必要です。' >&2
    exit 1
fi

missing_texlive_components() {
    missing_components=

    for executable_name in uplatex dvipdfmx kpsewhich; do
        if ! command -v "$executable_name" >/dev/null 2>&1; then
            missing_components="$missing_components $executable_name"
        fi
    done

    if command -v kpsewhich >/dev/null 2>&1; then
        for tex_file in jlreq.cls plautopatch.sty booktabs.sty; do
            if ! kpsewhich "$tex_file" >/dev/null 2>&1; then
                missing_components="$missing_components $tex_file"
            fi
        done
    fi

    printf '%s' "$missing_components"
}

missing_components=$(missing_texlive_components)
if [ -n "$missing_components" ]; then
    printf '不足しているTeX Liveのコマンドまたはパッケージ:%s\n' "$missing_components" >&2

    if [ ! -r /etc/os-release ] || ! grep -Eiq '^(ID|ID_LIKE)=.*(ubuntu|debian)' /etc/os-release; then
        printf '%s\n' 'Ubuntu / Debian では、次のAPTパッケージをインストールしてください:' >&2
        printf '%s\n' '  sudo apt-get install texlive-lang-japanese texlive-latex-recommended' >&2
        printf '%s\n' 'ほかの環境ではTeX Liveのパッケージ管理ツールを使ってください。' >&2
        exit 1
    fi

    if [ ! -t 0 ] || [ ! -t 2 ]; then
        printf '%s\n' '対話端末で ./install.sh を実行すると、APTインストールを確認できます。' >&2
        printf '%s\n' '手動の場合:' >&2
        printf '%s\n' '  sudo apt-get update' >&2
        printf '%s\n' '  sudo apt-get install texlive-lang-japanese texlive-latex-recommended' >&2
        exit 1
    fi

    printf '%s\n' 'APTのパッケージ一覧を更新し、次のパッケージをインストールします:' >&2
    printf '%s\n' '  texlive-lang-japanese texlive-latex-recommended' >&2
    printf '%s' '続行しますか? [y/N] ' >&2
    IFS= read -r install_answer
    case "$install_answer" in
        y|Y|yes|YES)
            if [ "$(id -u)" -eq 0 ]; then
                apt-get update
                apt-get install -y texlive-lang-japanese texlive-latex-recommended
            elif command -v sudo >/dev/null 2>&1; then
                sudo apt-get update
                sudo apt-get install -y texlive-lang-japanese texlive-latex-recommended
            else
                printf '%s\n' 'sudo が見つかりません。管理者権限でAPTパッケージをインストールしてください。' >&2
                exit 1
            fi
            ;;
        *)
            printf '%s\n' 'APTインストールを行いませんでした。必要パッケージを導入してから再実行してください。' >&2
            exit 1
            ;;
    esac

    missing_components=$(missing_texlive_components)
    if [ -n "$missing_components" ]; then
        printf 'インストール後も必要な項目が見つかりません:%s\n' "$missing_components" >&2
        exit 1
    fi
fi

printf '%s\n' '環境を確認しました。課題一覧:'
python3 "$repository_directory/drill" list
printf '\n%s\n' '準備完了です。例: ./drill read b01'
