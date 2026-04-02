# budoux.lua

[BudouX](https://github.com/google/budoux) 的 Lua 移植版 — 基於機器學習的換行位置最佳化工具。

BudouX 使用精巧的機器學習模型來偵測 CJK 文字中的自然詞邊界，實現比逐字分割更易讀的換行效果。

[English](README.md) | [日本語](README.ja.md) | [简体中文](README.zh-hans.md) | 繁體中文 | [ภาษาไทย](README.th.md)

## 安裝

### LuaRocks

```bash
luarocks install budoux
```

### lazy.nvim (Neovim)

```lua
{ "delphinus/budoux.lua" }
```

### 手動安裝

將 `lua/budoux/` 目錄複製到 Lua 套件路徑中。

## 使用方式

```lua
local budoux = require("budoux")

-- 建立對應語言的解析器
local parser = budoux.load_default_japanese_parser()

-- 將文字分割為自然詞組
local chunks = parser:parse("今日は天気がいいから散歩しましょう。")
-- → { "今日は", "天気が", "いいから", "散歩しましょう。" }

-- 簡體中文
local zh_hans = budoux.load_default_simplified_chinese_parser()
zh_hans:parse("我们的使命是整合全球信息，供大众使用，让人人受益。")
-- → { "我们", "的", "使命", "是", "整合", "全球", "信息，", "供", "大众", "使用，", "让", "人", "人", "受益。" }

-- 繁體中文
local zh_hant = budoux.load_default_traditional_chinese_parser()
zh_hant:parse("我們的使命是匯整全球資訊，供大眾使用，使人人受惠。")
-- → { "我們", "的", "使命", "是", "匯整", "全球", "資訊，", "供", "大眾", "使用，", "使", "人", "人", "受惠。" }

-- 泰語
local th = budoux.load_default_thai_parser()
th:parse("ภารกิจของเราคือการจัดระเบียบข้อมูลของโลก")
-- → { "ภาร", "กิจ", "ของ", "เรา", "คือ", "การ", "จัดระเบียบ", "ข้อมูล", "ของ", "โลก" }

-- 自訂模型
local parser = budoux.Parser.new(your_model_table)
```

## API

### `budoux.load_default_japanese_parser()`

回傳日語 `Parser`。

### `budoux.load_default_simplified_chinese_parser()`

回傳簡體中文 `Parser`。

### `budoux.load_default_traditional_chinese_parser()`

回傳繁體中文 `Parser`。

### `budoux.load_default_thai_parser()`

回傳泰語 `Parser`。

### `budoux.Parser.new(model)`

從自訂模型表建立 `Parser`。

- `model` — 包含特徵權重表（`UW1`–`UW6`、`BW1`–`BW3`、`TW1`–`TW4`）和 `base_score` 的表

### `parser:parse(text)`

使用 BudouX 模型將文字分割為區塊。

- `text` — 輸入文字字串
- 回傳值: `string[]` — 詞組區塊陣列

## 可用模型

| 模型 | 載入器 | 語言 |
|---|---|---|
| 日語 | `load_default_japanese_parser()` | 日語 |
| 簡體中文 | `load_default_simplified_chinese_parser()` | 簡體中文 |
| 繁體中文 | `load_default_traditional_chinese_parser()` | 繁體中文 |
| 泰語 | `load_default_thai_parser()` | 泰語 |

## 與 atusy/budoux.lua 的比較

另一個 BudouX 的 Lua 移植版：[atusy/budoux.lua](https://github.com/atusy/budoux.lua)。主要差異：

| | delphinus/budoux.lua | atusy/budoux.lua |
|---|---|---|
| API 風格 | Parser 物件 (`parser:parse(text)`) | 函式式 (`budoux.parse(model, text)`) |
| 支援語言 | 日語、簡體中文、繁體中文、泰語 | 僅日語 |
| 相依性 | 無（純 Lua） | lpeg 或 Neovim |
| 測試 / CI | busted + GitHub Actions (Lua 5.1–5.4, LuaJIT) | 無 |

## 授權條款

Apache-2.0 — 詳見 [LICENSE](LICENSE)。

本專案是 [BudouX](https://github.com/google/budoux)（Copyright 2021 Google LLC, Apache-2.0）的 Lua 移植版。詳情請參閱 [NOTICE](NOTICE)。
