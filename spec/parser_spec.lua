local budoux = require("budoux")

describe("Parser", function()
  describe("new", function()
    it("creates a parser from a model", function()
      local model = { UW4 = { a = 10000 }, base_score = 0 }
      local parser = budoux.Parser.new(model)
      assert.is_not_nil(parser)
      assert.are.same(model, parser.model)
    end)
  end)

  describe("parse", function()
    it("returns chunks split at boundaries", function()
      local parser = budoux.Parser.new({ UW4 = { a = 10000 }, base_score = 0 })
      local result = parser:parse("abcdeabcd")
      assert.are.same({ "abcde", "abcd" }, result)
    end)

    it("returns the input as-is for empty string", function()
      local parser = budoux.Parser.new({ UW4 = { a = 10000 }, base_score = 0 })
      local result = parser:parse("")
      assert.are.same({ "" }, result)
    end)

    it("returns the input as-is for short strings (<=3 chars)", function()
      local parser = budoux.Parser.new({ UW4 = { a = 10000 }, base_score = 0 })
      assert.are.same({ "abc" }, parser:parse("abc"))
      assert.are.same({ "ab" }, parser:parse("ab"))
      assert.are.same({ "a" }, parser:parse("a"))
    end)

    it("handles text with no break points", function()
      local parser = budoux.Parser.new({ UW4 = { z = 10000 }, base_score = 0 })
      local result = parser:parse("abcde")
      assert.are.same({ "abcde" }, result)
    end)
  end)
end)

describe("load_default_japanese_parser", function()
  it("parses Japanese text", function()
    local parser = budoux.load_default_japanese_parser()
    local result = parser:parse("今日は天気がいいから散歩しましょう。")
    assert.are.same({ "今日は", "天気が", "いいから", "散歩しましょう。" }, result)
  end)
end)

describe("load_default_simplified_chinese_parser", function()
  it("parses Simplified Chinese text", function()
    local parser = budoux.load_default_simplified_chinese_parser()
    local result = parser:parse("我们的使命是整合全球信息，供大众使用，让人人受益。")
    assert.are.same({
      "我们", "的", "使命", "是", "整合", "全球", "信息，",
      "供", "大众", "使用，", "让", "人", "人", "受益。",
    }, result)
  end)
end)

describe("load_default_traditional_chinese_parser", function()
  it("parses Traditional Chinese text", function()
    local parser = budoux.load_default_traditional_chinese_parser()
    local result = parser:parse("我們的使命是匯整全球資訊，供大眾使用，使人人受惠。")
    assert.are.same({
      "我們", "的", "使命", "是", "匯整", "全球", "資訊，",
      "供", "大眾", "使用，", "使", "人", "人", "受惠。",
    }, result)
  end)
end)

describe("load_default_thai_parser", function()
  it("parses Thai text", function()
    local parser = budoux.load_default_thai_parser()
    local result = parser:parse("ภารกิจของเราคือการจัดระเบียบข้อมูลของโลก")
    assert.are.same({
      "ภาร", "กิจ", "ของ", "เรา", "คือ", "การ",
      "จัดระเบียบ", "ข้อมูล", "ของ", "โลก",
    }, result)
  end)
end)

describe("split_by_script", function()
  it("splits kanji and hiragana (2+ kanji)", function()
    local result = budoux.split_by_script("参照してください")
    assert.are.same({ "参照", "してください" }, result)
  end)

  it("does not split single kanji + hiragana (okurigana)", function()
    local result = budoux.split_by_script("食べる")
    assert.are.same({ "食べる" }, result)
  end)

  it("splits katakana from other scripts", function()
    local result = budoux.split_by_script("東京タワー")
    assert.are.same({ "東京", "タワー" }, result)
  end)

  it("splits after nakaguro", function()
    local result = budoux.split_by_script("ユニグラム・バイグラム")
    assert.are.same({ "ユニグラム・", "バイグラム" }, result)
  end)

  it("returns single char as-is", function()
    assert.are.same({ "あ" }, budoux.split_by_script("あ"))
  end)

  it("returns empty string as-is", function()
    assert.are.same({ "" }, budoux.split_by_script(""))
  end)
end)
