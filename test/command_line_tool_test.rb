# frozen_string_literal: true

require 'test_helper'

class FdCommandLineTest < Minitest::Test
  EXPECTED_HELP_TEXT = <<~HELP_END
    Usage: fd [options] [file_names]
        -w, --width=WIDTH [Integer]      Display upto _width_ bytes per row, optional, default is 10
        -h, --help                       Display using this help
        -v, --version                    Display version info and quit

    When no file names a given fd reads from STDIN.
  HELP_END

  def test_has_version_number
    assert_match(/\A(\d+\.)+\d+\Z/, ::Fd::VERSION)
  end

  def test_works_with_ascii_input
    res = `bundle exec bin/fd test/test_data/word-list-ascii-ipsum.txt`
    assert_equal File.read('test/test_data/expected-output-word-list-ascii-ipsum.txt'), res
  end

  def test_transcribes_invisible_characters_with_given_width
    res = `bundle exec bin/fd -w 12 test/test_data/special-characters.txt`
    assert_equal File.read('test/test_data/expected-output-special-characters.txt'), res
  end

  def test_help_only_prints_help
    res = `bundle exec bin/fd -h no-such-file`
    assert_equal EXPECTED_HELP_TEXT, res
  end

  def test_print_version
    res = `bundle exec bin/fd -v`
    assert_match(/\Afd version: (\d+\.)+\d+\Z/, res)
  end

  def test_width_requires_one_parameter
    res = `bundle exec bin/fd -w 10 test/test_data/word-list-ascii-ipsum.txt`
    assert_equal File.read('test/test_data/expected-output-word-list-ascii-ipsum.txt'), res
  end

  def test_non_integer_width_parameter_causes_help_to_be_displayed
    res = `bundle exec bin/fd -w f10x test/test_data/word-list-ascii-ipsum.txt`
    exp = "fd doesn't work, this way:\n#{EXPECTED_HELP_TEXT}"
    assert_equal exp, res
  end

  def test_display_very_short_utf_8_text
    res = `bundle exec bin/fd test/test_data/short-utf-8-text.txt`
    assert_equal File.read('test/test_data/expected-output-short-utf-8-text.txt'), res
  end

  def test_display_long_utf_8_text
    res = `bundle exec bin/fd test/test_data/long-utf-8-text.txt`
    assert_equal File.read('test/test_data/expected-output-long-utf-8-text.txt'), res
  end

  def test_processes_stdin_when_no_file_is_given
    res = `echo What ever the text may be | bundle exec bin/fd`
    assert_equal File.read('test/test_data/expected-text-from-stdin.txt'), res
  end

  def test_processes_stdin_when_no_file_is_given_with_width
    res = `echo What ever the text may be | bundle exec bin/fd -w 12`
    assert_equal File.read('test/test_data/expected-text-from-stdin-with-width.txt'), res
  end

end
