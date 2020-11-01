# frozen_string_literal: true

require_relative '../command'

module Monte
  module Commands
    # Runs Monte Carlo Simulation to estimate how long a piece of work will take
    class Carlo < Monte::Command
      CERTAINTY = { 'low' => 1.8, 'medium' => 1.5, 'high' => 1.2 }.freeze
      RUNS = { '500' => 500, '1000' => 1000, '10000' => 10_000 }.freeze
      HEADERS = ['5%', '15%', '30%', '50%', '70%', '85%', '95%'].freeze
      PERCENTAGES = [0.05, 0.15, 0.3, 0.5, 0.7, 0.85, 0.95].freeze

      def initialize(options)
        @options = options
      end

      def execute(output: $stdout)
        user_input = ask_questions!
        simulations = run_simulations(user_input).sort
        results = define_table(simulations, user_input[:runs])
        output.puts(results)
      end

      # FIXME: do not like passing in runs this way
      def define_table(simulations, runs)
        rows = PERCENTAGES.map { |x| simulations[runs * x] }
        table(HEADERS, [rows]).render(:unicode, alignment: [:center])
      end

      def ask_questions!
        prompt.collect do
          key(:backlog).ask('How many items do you have in your backlog?', convert: :int)
          key(:split_factor).select('How certain are you with regard to the scope of the work?', CERTAINTY)
          key(:low).ask('What is the smallest number of tasks/tickets you have completed in a week?', convert: :int)
          key(:high).ask('What is the largest number of tasks/tickets you have completed in a week?', convert: :int)
          key(:runs).select('How many simulations would you like to run', RUNS)
        end
      end

      def run_simulations(backlog:, split_factor:, low:, high:, runs:)
        estimated_backlog = backlog * split_factor
        base_array = Array.new(runs)
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
