# frozen_string_literal: true

require_relative '../command'

module Monte
  module Commands
    # Runs Monte Carlo Simulation to estimate how long a piece of work will take
    class Carlo < Monte::Command
      CERTAINTY = { 'low' => 1.8, 'medium' => 1.5, 'high' => 1.2 }.freeze
      NUMBER_OF_RUNS = 100

      def initialize(options)
        @options = options
      end

      def execute(_: $stdin, output: $stdout)
        user_input = questions
        simulations = run_simulations(user_input).sort
        output.puts "It will take you between #{simulations[0]} weeks and #{simulations[-1]} to complete your work"
      end

      def questions
        prompt.collect do
          key(:backlog).ask('How many items do you have in your backlog?', convert: :int)
          key(:split_factor).select('How certain are you with regard to the scope of the work?', CERTAINTY)
          key(:low).ask('What is the smallest number of tasks you have completed in a week?', convert: :int)
          key(:high).ask('What is the largest number of tasks you have completed in a week?', convert: :int)
        end
      end

      def run_simulations(backlog:, split_factor:, low:, high:)
        estimated_backlog = backlog * split_factor
        base_array = Array.new(NUMBER_OF_RUNS)
        base_array.map do |_|
          simulate({ backlog: estimated_backlog, low: low, high: high })
        end
      end

      def simulate(backlog:, low:, high:, result: 0)
        return result if backlog <= 0

        simulate({ backlog: backlog - rand(low..high), low: low, high: high, result: result + 1 })
      end
    end
  end
end
