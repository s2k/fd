# frozen_string_literal: true

class FdTest < Minitest::Test
  def test_version_method
    assert_match(/\A(\d+\.)+\d+\Z/, Fd.version)
  end

  def test_version_is_consistent_in_constant_and_method
    assert_equal Fd::VERSION, Fd.version
  end
end
