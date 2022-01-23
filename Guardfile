# frozen_string_literal: true

guard :minitest do
  watch(%r{\Atest/(.*)/?(.*)test\.rb\Z})
  watch(%r{\Alib/(.*/)?([^/]+)\.rb\Z}) { 'test' }
  watch(%r{\Abin/fd\Z})                { 'test' }
  watch(%r{\Atest/test_helper\.rb\Z})  { 'test' }
end
