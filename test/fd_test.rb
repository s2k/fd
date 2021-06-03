# frozen_string_literal: true

require 'test_helper'

class FdTest < Minitest::Test
  def test_that_it_has_a_version_number
    assert_match %r{\A(\d+\.)+\d+\Z}, ::Fd::VERSION
  end

  def test_it_does_something_useful
    assert true
  end
end
