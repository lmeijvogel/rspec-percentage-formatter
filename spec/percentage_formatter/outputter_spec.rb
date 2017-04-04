require 'spec_helper'

describe PercentageFormatter::Output do
  it "mentions the approximate number of specs" do
    expected = "Running ~ 42 specs"

    output = StringIO.new

    outputter = PercentageFormatter::Output.new(output)

    outputter.start(42)

    output.rewind
    expect(output.read).to include(expected)
  end

  context "when there are fewer than 75 specs" do
    it "outputs every 20%" do
      expected = %r[
specs at 20%.*
specs at 40%.*
specs at 60%.*
specs at 80%.*
specs at 100%.*]m

      output = StringIO.new

      outputter = PercentageFormatter::Output.new(output)

      outputter.start(74)

      74.times do
        outputter.increment
      end

      output.rewind

      expect(output.read).to match(expected)
    end
  end

  context "when there are between 75 and 200 specs" do
    it "outputs every 10%" do
      expected = %r[
specs at 0%.*
specs at 10%.*
specs at 20%.*
specs at 30%.*
specs at 40%.*
specs at 50%.*
specs at 60%.*
specs at 70%.*
specs at 80%.*
specs at 90%.*
specs at 100%.*]m

      output = StringIO.new

      outputter = PercentageFormatter::Output.new(output)

      outputter.start(100)

      100.times do
        outputter.increment
      end

      output.rewind

      expect(output.read).to match(expected)
    end
  end

  context "when there are more than 200 specs" do
    it "outputs every 5%" do
      expected = %r[
specs at 5%.*
specs at 10%.*
specs at 15%.*
specs at 20%.*
specs at 25%.*
specs at 30%.*
specs at 35%.*
specs at 40%.*
specs at 45%.*
specs at 50%.*
specs at 55%.*
specs at 60%.*
specs at 65%.*
specs at 70%.*
specs at 75%.*
specs at 80%.*
specs at 85%.*
specs at 90%.*
specs at 95%.*
specs at 100%.*]m

      output = StringIO.new

      outputter = PercentageFormatter::Output.new(output)

      outputter.start(201)

      201.times do
        outputter.increment
      end

      output.rewind

      expect(output.read).to match(expected)
    end

  end
end

