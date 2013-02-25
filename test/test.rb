
require 'rubygems'
require 'bundler/setup'

require 'toml-ruby'
require 'minitest/autorun'

class TestParser < MiniTest::Unit::TestCase
  def setup
    filepath = File.join(File.dirname(__FILE__), 'spec.toml')
    @doc = Toml.load(File.open(filepath))
  end
  
  def test_string
    assert_equal @doc["string"], "string\n\t\"string"
  end
  def test_integer
    assert_equal @doc["integer"], 42
  end
  def test_float
    assert_equal @doc["pi"], 3.14159
  end
  def test_datetime
    assert_equal @doc["datetime"], DateTime.iso8601("1979-05-27T07:32:00Z")
  end
  def test_simple_array
    assert_equal @doc["simple_array"], [1, 2, 3]
  end
  def test_nested_array
    assert_equal @doc["nested_array"], [[[1], 2], 3, [4]]
  end
  def test_string_array
    assert_equal @doc["string_array"], ["a", "b", "c"]
  end
  def test_simple_keygroup
    assert_equal @doc["e"]["f"], "test"
  end
  def test_nested_keygroup
    assert_equal @doc["a"]["b"]["c"]["d"], "test"
  end
  def test_string_with_comment
    assert_equal @doc["string_with_comment"], "string with #comment"
  end
  def test_comment_after_string
    assert_equal @doc["string_with_comment_afterwards"], "string"
  end
  def test_array_with_comments_in_strings
    assert_equal @doc["array_with_comment"], ["a", "b#b", "#c"]
  end
  def test_array_with_closing_bracket_in_string
    assert_equal @doc["array_with_closing_bracket"], ["a", "b]b", "#c"]
  end
  def test_array_with_closing_bracket_in_string_and_comment
    assert_equal @doc["array_with_closing_bracket_and_ending_comment"], ["a", "b]b", "#c"]
  end
end
