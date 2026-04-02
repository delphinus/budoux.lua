# budoux.lua

A Lua port of [BudouX](https://github.com/google/budoux) — the machine learning powered line break organizer tool.

BudouX uses a compact ML model to find natural word boundaries in CJK text, producing more readable line breaks than character-level splitting.

## Status

This is an initial release (v0.1.0) with the Japanese model only. A future release will include full API compatibility with the original BudouX, additional language models (Simplified/Traditional Chinese, Thai), and LuaRocks publishing.

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
local ja = require("budoux.models.ja")

-- Split text into natural phrases
local chunks = budoux.parse(ja, "今日は天気がいいから散歩しましょう。")
-- → { "今日は", "天気が", "いいから", "散歩しましょう。" }

-- Further split by script boundaries (kanji ↔ kana)
local sub = budoux.split_by_script("参照してください")
-- → { "参照", "してください" }
```

## API

### `budoux.parse(model, text)`

Parse text into chunks using the BudouX model.

- `model` — a model table (e.g. `require("budoux.models.ja")`)
- `text` — input text string
- Returns: `string[]` — array of phrase chunks

### `budoux.split_by_script(chunk)`

Sub-split a chunk at script transition boundaries (kanji/katakana to other scripts). This is not part of the original BudouX but useful for finer-grained line breaking.

- `chunk` — a string to split
- Returns: `string[]` — array of sub-chunks

## Available Models

| Model | Require path | Language |
|---|---|---|
| Japanese | `budoux.models.ja` | Japanese |

More models (Simplified Chinese, Traditional Chinese, Thai) will be added in a future release.

## License

Apache-2.0 — see [LICENSE](LICENSE).

This project is a Lua port of [BudouX](https://github.com/google/budoux) (Copyright 2021 Google LLC, Apache-2.0). See [NOTICE](NOTICE) for details.
