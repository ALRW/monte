# frozen_string_literal: true

require_relative '../command'

module Monte
  module Commands
    class Carlo < Monte::Command
      def initialize(options)
        @options = options
      end

      def execute(_: $stdin, output: $stdout)
        result = prompt.collect do
          key(:backlog).ask('How many items do you have in your backlog?', convert: :int)
          key(:low).ask('What is the smallest number of tasks you have completed in a week?', convert: :int)
          key(:high).ask('What is the largest number of tasks you have completed in a week?', convert: :int)
        end
        number_of_weeks = simulate(result)
        output.puts "It will take you #{number_of_weeks} weeks to complete your work"
      end

      def simulate(backlog:, low:, high:, result: 0)
        return result if backlog <= 0

        simulate({ backlog: backlog - rand(low..high), low: low, high: high, result: result + 1 })
      end
    end
  end
end
