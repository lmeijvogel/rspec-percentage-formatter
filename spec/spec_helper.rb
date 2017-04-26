require "bundler/setup"
require "percentage_formatter"

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
