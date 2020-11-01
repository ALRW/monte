# frozen_string_literal: true

require 'date'
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
        output.puts("Monte Carlo Forecasting\n\nPlease answer the following:\n")
        user_input = ask_questions!
        simulations = run_simulations(user_input).sort
        results = define_table({ simulations: simulations, **user_input })
        output.puts("\n\nYour Results\n\n")
        output.puts(results)
      end

      def define_table(args)
        rows = PERCENTAGES.map do |x|
          days_to_complete_tasks = args[:simulations][args[:runs] * x] * 7
          date_time = args[:start_date] + days_to_complete_tasks
          date_time.to_date.to_s
        end
        table(HEADERS, [rows]).render(:unicode, alignment: [:center])
      end

      # FIXME: refactor out questions and improve validations and messaging
      def ask_questions!
        prompt.collect do
          key(:backlog).ask('How many items do you have in your backlog?', convert: :int)
          key(:split_factor).select('How certain are you with regard to the scope of the work?', CERTAINTY)
          key(:start_date).ask('When will you start work (e.g. 28/04/2021)') do |q|
            q.default DateTime.now.to_date.to_s
            q.convert ->(input) { DateTime.parse(input) }
          end
          key(:low).ask('What is the smallest number of tasks/tickets you have completed in a week?', convert: :int)
          key(:high).ask('What is the largest number of tasks/tickets you have completed in a week?', convert: :int)
          key(:runs).select('How many simulations would you like to run', RUNS)
        end
      end

      def run_simulations(args)
        estimated_backlog = args[:backlog] * args[:split_factor]
        base_array = Array.new(args[:runs])
        base_array.map do |_|
          simulate(backlog: estimated_backlog, low: args[:low], high: args[:high])
        end
      end

      def simulate(backlog:, low:, high:, result: 0)
        return result if backlog <= 0

        simulate(backlog: backlog - rand(low..high), low: low, high: high, result: result + 1)
      end
    end
  end
end
