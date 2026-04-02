# budoux.lua

พอร์ต Lua ของ [BudouX](https://github.com/google/budoux) — เครื่องมือจัดการตำแหน่งการตัดบรรทัดด้วยการเรียนรู้ของเครื่อง

BudouX ใช้โมเดล ML ขนาดเล็กในการค้นหาขอบเขตคำที่เป็นธรรมชาติในข้อความ CJK ทำให้การตัดบรรทัดอ่านง่ายกว่าการแบ่งทีละตัวอักษร

[English](README.md) | [日本語](README.ja.md) | [简体中文](README.zh-hans.md) | [繁體中文](README.zh-hant.md) | ภาษาไทย

## การติดตั้ง

### lazy.nvim (Neovim)

```lua
{ "delphinus/budoux.lua" }
```

### ติดตั้งด้วยตนเอง

คัดลอกไดเรกทอรี `lua/budoux/` ไปยัง Lua package path ของคุณ

## การใช้งาน

```lua
local budoux = require("budoux")

-- สร้าง parser สำหรับภาษาของคุณ
local parser = budoux.load_default_japanese_parser()

-- แบ่งข้อความเป็นวลีที่เป็นธรรมชาติ
local chunks = parser:parse("今日は天気がいいから散歩しましょう。")
-- → { "今日は", "天気が", "いいから", "散歩しましょう。" }

-- ภาษาจีนตัวย่อ
local zh_hans = budoux.load_default_simplified_chinese_parser()
zh_hans:parse("我们的使命是整合全球信息，供大众使用，让人人受益。")
-- → { "我们", "的", "使命", "是", "整合", "全球", "信息，", "供", "大众", "使用，", "让", "人", "人", "受益。" }

-- ภาษาจีนตัวเต็ม
local zh_hant = budoux.load_default_traditional_chinese_parser()
zh_hant:parse("我們的使命是匯整全球資訊，供大眾使用，使人人受惠。")
-- → { "我們", "的", "使命", "是", "匯整", "全球", "資訊，", "供", "大眾", "使用，", "使", "人", "人", "受惠。" }

-- ภาษาไทย
local th = budoux.load_default_thai_parser()
th:parse("ภารกิจของเราคือการจัดระเบียบข้อมูลของโลก")
-- → { "ภาร", "กิจ", "ของ", "เรา", "คือ", "การ", "จัดระเบียบ", "ข้อมูล", "ของ", "โลก" }

-- โมเดลกำหนดเอง
local parser = budoux.Parser.new(your_model_table)
```

## API

### `budoux.load_default_japanese_parser()`

คืนค่า `Parser` สำหรับภาษาญี่ปุ่น

### `budoux.load_default_simplified_chinese_parser()`

คืนค่า `Parser` สำหรับภาษาจีนตัวย่อ

### `budoux.load_default_traditional_chinese_parser()`

คืนค่า `Parser` สำหรับภาษาจีนตัวเต็ม

### `budoux.load_default_thai_parser()`

คืนค่า `Parser` สำหรับภาษาไทย

### `budoux.Parser.new(model)`

สร้าง `Parser` จากตารางโมเดลกำหนดเอง

- `model` — ตารางที่มีตารางน้ำหนักฟีเจอร์ (`UW1`–`UW6`, `BW1`–`BW3`, `TW1`–`TW4`) และ `base_score`

### `parser:parse(text)`

แยกข้อความเป็นชิ้นส่วนโดยใช้โมเดล BudouX

- `text` — สตริงข้อความอินพุต
- คืนค่า: `string[]` — อาร์เรย์ของชิ้นส่วนวลี

## โมเดลที่มีให้ใช้

| โมเดล | ตัวโหลด | ภาษา |
|---|---|---|
| ญี่ปุ่น | `load_default_japanese_parser()` | ญี่ปุ่น |
| จีนตัวย่อ | `load_default_simplified_chinese_parser()` | จีนตัวย่อ |
| จีนตัวเต็ม | `load_default_traditional_chinese_parser()` | จีนตัวเต็ม |
| ไทย | `load_default_thai_parser()` | ไทย |

## เปรียบเทียบกับ atusy/budoux.lua

พอร์ต Lua ของ BudouX อีกตัว: [atusy/budoux.lua](https://github.com/atusy/budoux.lua) ความแตกต่างหลัก:

| | delphinus/budoux.lua | atusy/budoux.lua |
|---|---|---|
| รูปแบบ API | Parser object (`parser:parse(text)`) | แบบฟังก์ชัน (`budoux.parse(model, text)`) |
| ภาษาที่รองรับ | ญี่ปุ่น, จีนตัวย่อ, จีนตัวเต็ม, ไทย | ญี่ปุ่นเท่านั้น |
| การพึ่งพา | ไม่มี (Lua ล้วน) | lpeg หรือ Neovim |
| การทดสอบ / CI | busted + GitHub Actions (Lua 5.1–5.4, LuaJIT) | ไม่มี |

## สัญญาอนุญาต

Apache-2.0 — ดู [LICENSE](LICENSE)

โปรเจกต์นี้เป็นพอร์ต Lua ของ [BudouX](https://github.com/google/budoux) (Copyright 2021 Google LLC, Apache-2.0) ดูรายละเอียดที่ [NOTICE](NOTICE)
