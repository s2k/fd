# guard :rspec, cmd: 'bundle exec rspec --color --format doc', all_on_start: true do
#   require 'guard/rspec/dsl'
#   dsl = Guard::RSpec::Dsl.new(self)
#
#   # RSpec files
#   rspec = dsl.rspec
#   watch(rspec.spec_helper) { rspec.spec_dir }
#   watch(rspec.spec_support) { rspec.spec_dir }
#   watch(rspec.spec_files) { rspec.spec_dir }
#   watch(%r{^lib/(.+)\.rb$}) { rspec.spec_dir }
#
#   # Ruby files
#   ruby = dsl.ruby
#   dsl.watch_spec_files_for(ruby.lib_files)
# end

guard :minitest do
  watch(%r{^test/(.*)\/?test_(.*)\.rb$})
  watch(%r{^lib/(.*/)?([^/]+)\.rb$})     { |m| "test/#{m[1]}test_#{m[2]}.rb" }
  watch(%r{^test/test_helper\.rb$})      { 'test' }

end
