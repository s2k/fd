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
end
