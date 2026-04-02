# budoux.lua

[BudouX](https://github.com/google/budoux) の Lua 移植版 — 機械学習を用いた改行位置最適化ツール。

BudouX はコンパクトな ML モデルを使い、CJK テキスト中の自然な単語境界を検出します。文字単位の分割よりも読みやすい改行を実現します。

[English](README.md) | 日本語 | [简体中文](README.zh-hans.md) | [繁體中文](README.zh-hant.md) | [ภาษาไทย](README.th.md)

## インストール

### LuaRocks

```bash
luarocks install budoux
```

### lazy.nvim (Neovim)

```lua
{ "delphinus/budoux.lua" }
```

### 手動

`lua/budoux/` ディレクトリを Lua のパッケージパスにコピーしてください。

## 使い方

```lua
local budoux = require("budoux")

-- 言語に応じたパーサーを作成
local parser = budoux.load_default_japanese_parser()

-- テキストを自然なフレーズに分割
local chunks = parser:parse("今日は天気がいいから散歩しましょう。")
-- → { "今日は", "天気が", "いいから", "散歩しましょう。" }

-- 簡体字中国語
local zh_hans = budoux.load_default_simplified_chinese_parser()
zh_hans:parse("我们的使命是整合全球信息，供大众使用，让人人受益。")
-- → { "我们", "的", "使命", "是", "整合", "全球", "信息，", "供", "大众", "使用，", "让", "人", "人", "受益。" }

-- 繁体字中国語
local zh_hant = budoux.load_default_traditional_chinese_parser()
zh_hant:parse("我們的使命是匯整全球資訊，供大眾使用，使人人受惠。")
-- → { "我們", "的", "使命", "是", "匯整", "全球", "資訊，", "供", "大眾", "使用，", "使", "人", "人", "受惠。" }

-- タイ語
local th = budoux.load_default_thai_parser()
th:parse("ภารกิจของเราคือการจัดระเบียบข้อมูลของโลก")
-- → { "ภาร", "กิจ", "ของ", "เรา", "คือ", "การ", "จัดระเบียบ", "ข้อมูล", "ของ", "โลก" }

-- カスタムモデル
local parser = budoux.Parser.new(your_model_table)
```

## API

### `budoux.load_default_japanese_parser()`

日本語用の `Parser` を返します。

### `budoux.load_default_simplified_chinese_parser()`

簡体字中国語用の `Parser` を返します。

### `budoux.load_default_traditional_chinese_parser()`

繁体字中国語用の `Parser` を返します。

### `budoux.load_default_thai_parser()`

タイ語用の `Parser` を返します。

### `budoux.Parser.new(model)`

カスタムモデルテーブルから `Parser` を作成します。

- `model` — 特徴量の重みテーブル（`UW1`〜`UW6`、`BW1`〜`BW3`、`TW1`〜`TW4`）と `base_score` を含むテーブル

### `parser:parse(text)`

BudouX モデルを使ってテキストをチャンクに分割します。

- `text` — 入力テキスト文字列
- 戻り値: `string[]` — フレーズチャンクの配列

## 利用可能なモデル

| モデル | ローダー | 言語 |
|---|---|---|
| 日本語 | `load_default_japanese_parser()` | 日本語 |
| 簡体字中国語 | `load_default_simplified_chinese_parser()` | 簡体字中国語 |
| 繁体字中国語 | `load_default_traditional_chinese_parser()` | 繁体字中国語 |
| タイ語 | `load_default_thai_parser()` | タイ語 |

## atusy/budoux.lua との比較

BudouX の Lua 移植版として [atusy/budoux.lua](https://github.com/atusy/budoux.lua) もあります。主な違い:

| | delphinus/budoux.lua | atusy/budoux.lua |
|---|---|---|
| API スタイル | Parser オブジェクト (`parser:parse(text)`) | 関数ベース (`budoux.parse(model, text)`) |
| 対応言語 | 日本語・簡体字中国語・繁体字中国語・タイ語 | 日本語のみ |
| 依存関係 | なし（純粋な Lua） | lpeg または Neovim |
| テスト / CI | busted + GitHub Actions (Lua 5.1〜5.4, LuaJIT) | なし |

## ライセンス

Apache-2.0 — [LICENSE](LICENSE) を参照。

本プロジェクトは [BudouX](https://github.com/google/budoux)（Copyright 2021 Google LLC, Apache-2.0）の Lua 移植版です。詳細は [NOTICE](NOTICE) を参照してください。
