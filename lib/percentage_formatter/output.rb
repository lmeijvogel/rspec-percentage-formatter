require 'rspec/instafail'

class PercentageFormatter < RSpec::Core::Formatters::BaseTextFormatter
  class Output
    attr_accessor :rspec_output, :number_of_examples_executed, :last_printed_percentage

    PERCENTAGE_SEGMENT_SIZE = 5

    def initialize(rspec_output)
      self.rspec_output = rspec_output

      self.number_of_examples_executed = 0
      self.last_printed_percentage = -1
    end

    def start(example_count)
      @example_count = example_count

      rspec_output.puts
      rspec_output.puts("Running ~ #{example_count} specs")
      rspec_output.puts
    end

    def increment
      self.number_of_examples_executed += 1

      print_percentage_if_needed
    end

    def failure(notification)
      instafail.example_failed(notification)
      rspec_output.puts
    end

    private
    def print_percentage_if_needed
      percentage_to_print = floor_to_printable_percentage(percentage_done)

      if self.last_printed_percentage != percentage_to_print
        rspec_output.puts( "specs at #{ percentage_to_print }%" )

        self.last_printed_percentage = percentage_to_print
      end
    end

    def floor_to_printable_percentage(number)
      ((number / PERCENTAGE_SEGMENT_SIZE).floor * PERCENTAGE_SEGMENT_SIZE).to_i
    end

    def percentage_done
      (self.number_of_examples_executed.to_f / @example_count) * 100
    end

    def instafail
      @instafail ||= RSpec::Instafail.new(rspec_output)
    end
  end
end
