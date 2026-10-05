# トラックmanifest

各トラックは `curriculum/<level>.json` に定義します。1課題は1つの読み物、編集用ディレクトリ、初期状態、解答、公式資料、チェック項目を持ちます。

```json
{
  "level": "beginner",
  "display_name": "初級",
  "exercises": [
    {
      "id": "b01",
      "title": "最小の和文文書",
      "lecture": "docs/beginner/b01.md",
      "exercise_dir": "exercises/b01",
      "template_dir": "templates/b01",
      "solution_dir": "solutions/b01",
      "main": "main.tex",
      "engine": "uplatex",
      "checks": [
        {
          "file": "main.tex",
          "contains": "\\documentclass{jlreq}",
          "hint": "文書クラスを指定してください。"
        }
      ],
      "aux_checks": [],
      "references": [
        {"title": "Learn LaTeX: 文書構造", "url": "https://www.learnlatex.org/ja/lesson-03"}
      ],
      "hints": ["対応する読み物を先に確認します。"]
    }
  ]
}
```

- `checks` は編集対象ファイルに必須の文字列を確認します。1項目につき、失敗時のヒントを付けます。
- `aux_checks` は組版後の `.aux` などに生成される文字列を確認します。相互参照の課題で使います。
- `completion_files` は完了マーカーを確認するファイル一覧です。省略すると `main` だけを確認します。
- `engine` は `uplatex`、`platex`、`lualatex` のいずれかです。pLaTeX系では `dvipdfmx` でPDFにします。
- `compile_passes` を省略すると2回組版します。
