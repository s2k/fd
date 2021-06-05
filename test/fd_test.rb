# frozen_string_literal: true

require 'test_helper'

class FdTest < Minitest::Test
  def test_has_version_number
    assert_match %r{\A(\d+\.)+\d+\Z}, ::Fd::VERSION
  end

  def test_works_with_ascii_input
    res = `bundle exec exe/fd test/test_data/word-list-ascii-ipsum.txt`
    assert_equal File.read('test/test_data/expected-word-list-ascii-ipsum-output.txt'), res
  end

  def test_transcribes_invisible_characters_with_given_width
    res = `bundle exec exe/fd -w 12 test/test_data/special-characters.txt`
    assert_equal File.read('test/test_data/expected-special-characters-output.txt'), res
  end

  def test_help_only_prints_help
    expected = <<-END
Usage: fd.rb file_name_list

file_name_list: one or more file names

Options

--help or -h           : This help text
--width or -w a_number : Sets the number of values per line in the output
    END
    res = `bundle exec exe/fd -h no-such-file`
    assert_equal expected, res
  end
end
