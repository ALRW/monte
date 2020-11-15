# frozen_string_literal: true

require 'date'
require_relative '../command'
require_relative '../simulation'

module Monte
  module Commands
    # Runs Monte Carlo Simulation to estimate how long a piece of work will take
    class Carlo < Monte::Command
      include Simulation
      BLURB = %(Welcome to Monte, a tool to help you answer the question: 'When will the work be done?'\n\n
Please answer the following questions\n)
      CERTAINTY = { 'low' => 1.8, 'medium' => 1.5, 'high' => 1.2 }.freeze
      RUNS = { '10000' => 10_000, '1000' => 1000, '500' => 500 }.freeze
      HEADERS = ['Forecast Certainty', '5%', '15%', '30%', '50%', '70%', '85%', '95%'].freeze
      PERCENTILES = [0.05, 0.15, 0.3, 0.5, 0.7, 0.85, 0.95].freeze

      def initialize(options)
        @options = options
      end

      def execute(output: $stdout)
        output.puts(create_header, BLURB)
        user_input = ask_questions!
        results = percentiles(user_input)
        output.puts(create_table(results))
      end

      def create_table(rows)
        table(HEADERS, [rows.prepend('Forecast Date')])
          .render(:unicode, alignment: [:center])
      end

      def create_header
        large_title('Monte')
      end

      def ask_questions!
        prompt.collect do
          key(:backlog).ask('How many tasks/tickets do you have left to complete?', convert: :int)
          key(:split_factor).select('How certain are you with regard to the scope of the work?', CERTAINTY)
          key(:start_date).ask('When will you start work (e.g. 28/04/2021)') do |q|
            q.default Date.today
            q.convert ->(input) { Date.parse(input.to_s) }
          end
          key(:low).ask('What is the smallest number of tasks/tickets you have completed in a week?', convert: :int)
          key(:high).ask('What is the largest number of tasks/tickets you have completed in a week?', convert: :int)
          key(:runs).select('How many simulations would you like to run', RUNS)
        end
      end

    end
  end
end
