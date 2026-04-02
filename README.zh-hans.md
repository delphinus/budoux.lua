# budoux.lua

[BudouX](https://github.com/google/budoux) 的 Lua 移植版 — 基于机器学习的换行位置优化工具。

BudouX 使用紧凑的机器学习模型来检测 CJK 文本中的自然词边界，实现比逐字分割更易读的换行效果。

[English](README.md) | [日本語](README.ja.md) | 简体中文 | [繁體中文](README.zh-hant.md) | [ภาษาไทย](README.th.md)

## 安装

### lazy.nvim (Neovim)

```lua
{ "delphinus/budoux.lua" }
```

### 手动安装

将 `lua/budoux/` 目录复制到 Lua 包路径中。

## 使用方法

```lua
local budoux = require("budoux")

-- 创建对应语言的解析器
local parser = budoux.load_default_japanese_parser()

-- 将文本分割为自然短语
local chunks = parser:parse("今日は天気がいいから散歩しましょう。")
-- → { "今日は", "天気が", "いいから", "散歩しましょう。" }

-- 简体中文
local zh_hans = budoux.load_default_simplified_chinese_parser()
zh_hans:parse("我们的使命是整合全球信息，供大众使用，让人人受益。")
-- → { "我们", "的", "使命", "是", "整合", "全球", "信息，", "供", "大众", "使用，", "让", "人", "人", "受益。" }

-- 繁体中文
local zh_hant = budoux.load_default_traditional_chinese_parser()
zh_hant:parse("我們的使命是匯整全球資訊，供大眾使用，使人人受惠。")
-- → { "我們", "的", "使命", "是", "匯整", "全球", "資訊，", "供", "大眾", "使用，", "使", "人", "人", "受惠。" }

-- 泰语
local th = budoux.load_default_thai_parser()
th:parse("ภารกิจของเราคือการจัดระเบียบข้อมูลของโลก")
-- → { "ภาร", "กิจ", "ของ", "เรา", "คือ", "การ", "จัดระเบียบ", "ข้อมูล", "ของ", "โลก" }

-- 自定义模型
local parser = budoux.Parser.new(your_model_table)
```

## API

### `budoux.load_default_japanese_parser()`

返回日语 `Parser`。

### `budoux.load_default_simplified_chinese_parser()`

返回简体中文 `Parser`。

### `budoux.load_default_traditional_chinese_parser()`

返回繁体中文 `Parser`。

### `budoux.load_default_thai_parser()`

返回泰语 `Parser`。

### `budoux.Parser.new(model)`

从自定义模型表创建 `Parser`。

- `model` — 包含特征权重表（`UW1`–`UW6`、`BW1`–`BW3`、`TW1`–`TW4`）和 `base_score` 的表

### `parser:parse(text)`

使用 BudouX 模型将文本分割为块。

- `text` — 输入文本字符串
- 返回值: `string[]` — 短语块数组

## 可用模型

| 模型 | 加载器 | 语言 |
|---|---|---|
| 日语 | `load_default_japanese_parser()` | 日语 |
| 简体中文 | `load_default_simplified_chinese_parser()` | 简体中文 |
| 繁体中文 | `load_default_traditional_chinese_parser()` | 繁体中文 |
| 泰语 | `load_default_thai_parser()` | 泰语 |

## 与 atusy/budoux.lua 的比较

另一个 BudouX 的 Lua 移植版：[atusy/budoux.lua](https://github.com/atusy/budoux.lua)。主要区别：

| | delphinus/budoux.lua | atusy/budoux.lua |
|---|---|---|
| API 风格 | Parser 对象 (`parser:parse(text)`) | 函数式 (`budoux.parse(model, text)`) |
| 支持语言 | 日语、简体中文、繁体中文、泰语 | 仅日语 |
| 依赖 | 无（纯 Lua） | lpeg 或 Neovim |
| 测试 / CI | busted + GitHub Actions (Lua 5.1–5.4, LuaJIT) | 无 |

## 许可证

Apache-2.0 — 详见 [LICENSE](LICENSE)。

本项目是 [BudouX](https://github.com/google/budoux)（Copyright 2021 Google LLC, Apache-2.0）的 Lua 移植版。详情请参阅 [NOTICE](NOTICE)。
