# budoux.lua

A Lua port of [BudouX](https://github.com/google/budoux) — the machine learning powered line break organizer tool.

BudouX uses a compact ML model to find natural word boundaries in CJK text, producing more readable line breaks than character-level splitting.

## Installation

### lazy.nvim (Neovim)

```lua
{ "delphinus/budoux.lua" }
```

### Manual

Copy the `lua/budoux/` directory into your Lua package path.

## Usage

```lua
local budoux = require("budoux")

-- Create a parser for your language
local parser = budoux.load_default_japanese_parser()

-- Split text into natural phrases
local chunks = parser:parse("今日は天気がいいから散歩しましょう。")
-- → { "今日は", "天気が", "いいから", "散歩しましょう。" }

-- Other languages
local zh_hans = budoux.load_default_simplified_chinese_parser()
local zh_hant = budoux.load_default_traditional_chinese_parser()
local th = budoux.load_default_thai_parser()

-- Custom model
local parser = budoux.Parser.new(your_model_table)
```

## API

### `budoux.load_default_japanese_parser()`

Returns a `Parser` for Japanese.

### `budoux.load_default_simplified_chinese_parser()`

Returns a `Parser` for Simplified Chinese.

### `budoux.load_default_traditional_chinese_parser()`

Returns a `Parser` for Traditional Chinese.

### `budoux.load_default_thai_parser()`

Returns a `Parser` for Thai.

### `budoux.Parser.new(model)`

Create a `Parser` from a custom model table.

- `model` — a table with feature weight tables (`UW1`–`UW6`, `BW1`–`BW3`, `TW1`–`TW4`) and `base_score`

### `parser:parse(text)`

Parse text into chunks using the BudouX model.

- `text` — input text string
- Returns: `string[]` — array of phrase chunks

## Available Models

| Model | Loader | Language |
|---|---|---|
| Japanese | `load_default_japanese_parser()` | Japanese |
| Simplified Chinese | `load_default_simplified_chinese_parser()` | Simplified Chinese |
| Traditional Chinese | `load_default_traditional_chinese_parser()` | Traditional Chinese |
| Thai | `load_default_thai_parser()` | Thai |

## License

Apache-2.0 — see [LICENSE](LICENSE).

This project is a Lua port of [BudouX](https://github.com/google/budoux) (Copyright 2021 Google LLC, Apache-2.0). See [NOTICE](NOTICE) for details.
