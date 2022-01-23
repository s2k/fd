# frozen_string_literal: true

require 'test_helper'

class FdTest < Minitest::Test
  EXPECTED_HELP_TEXT = <<~END
    Usage: fd [options] file_names
        -w, --width=WIDTH [Integer]      Display upto _width_ bytes per row, optional, default is 10
        -h, --help                       Display using this help
  END

  def test_has_version_number
    assert_match %r{\A(\d+\.)+\d+\Z}, ::Fd::VERSION
  end

  def test_works_with_ascii_input
    res = `bundle exec exe/fd test/test_data/word-list-ascii-ipsum.txt`
    assert_equal File.read('test/test_data/expected-output-word-list-ascii-ipsum.txt'), res
  end

  def test_transcribes_invisible_characters_with_given_width
    res = `bundle exec exe/fd -w 12 test/test_data/special-characters.txt`
    assert_equal File.read('test/test_data/expected-output-special-characters.txt'), res
  end

  def test_help_only_prints_help
    res = `bundle exec exe/fd -h no-such-file`
    assert_equal EXPECTED_HELP_TEXT, res
  end

  def test_width_requires_one_parameter
    res = `bundle exec exe/fd -w 10 test/test_data/word-list-ascii-ipsum.txt`
    assert_equal File.read('test/test_data/expected-output-word-list-ascii-ipsum.txt'), res
  end

  def test_non_integer_width_parameter_causes_help_to_be_displayed
    res = `bundle exec exe/fd -w f10x test/test_data/word-list-ascii-ipsum.txt`
    exp = "fd doesn't work, this way:\n" + EXPECTED_HELP_TEXT
    assert_equal exp, res
  end

  def test_display_very_short_utf_8_text
    res = `bundle exec exe/fd test/test_data/short-utf-8-text.txt`
    assert_equal File.read('test/test_data/expected-output-short-utf-8-text.txt'), res
  end

  def test_display_long_utf_8_text
    res = `bundle exec exe/fd test/test_data/long-utf-8-text.txt`
    assert_equal File.read('test/test_data/expected-output-long-utf-8-text.txt'), res
  end
end
