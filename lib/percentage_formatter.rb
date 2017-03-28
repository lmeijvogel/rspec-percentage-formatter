require 'rspec/core/formatters/base_text_formatter'
require 'percentage_formatter/output.rb'

class PercentageFormatter < RSpec::Core::Formatters::BaseTextFormatter
  RSpec::Core::Formatters.register self, :start, :example_started, :example_failed

  attr_accessor :outputter

  def initialize(output)
    super

    self.outputter = PercentageFormatter::Output.new(output)
  end

  def start(notification)
    super

    outputter.start(notification.count)
  end

  def example_started(notification)
    outputter.increment
  end

  def example_failed(notification)
    outputter.failure(notification)
  end
end
