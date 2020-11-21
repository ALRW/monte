# frozen_string_literal: true

require 'date'
require_relative '../command'
require_relative '../simulation'
require_relative '../csv_data'

module Monte
  module Commands
    # Runs Monte Carlo Simulation to estimate how long a piece of work will take
    class Carlo < Monte::Command
      include Simulation
      include CSVData
      BLURB = %(Welcome to Monte, a tool to help you answer the question: 'When will the work be done?'\n\n
Please answer the following questions\n)
      CERTAINTY = { 'certain' => 1.0, 'high' => 1.2, 'medium' => 1.5, 'low' => 1.8 }.freeze
      RUNS = { '10000' => 10_000, '1000' => 1000, '500' => 500 }.freeze
      HEADERS = ['Forecast Certainty', '5%', '15%', '30%', '50%', '70%', '85%', '95%'].freeze
      PERCENTILES = [0.05, 0.15, 0.3, 0.5, 0.7, 0.85, 0.95].freeze

      def execute
        puts(create_header, BLURB)
        user_input = ask_questions({})
        results = percentiles(user_input)
        puts(create_table(results))
      end

      def create_table(rows)
        table(HEADERS, [rows.prepend('Forecast Date')])
          .render(:unicode, alignment: [:center])
      end

      def create_header
        large_title('Monte')
      end

      def ask_questions(options)
        q1 = ask_backlog(options)
        q2 = ask_throughput(q1)
        q3 = ask_start(q2)
        q4 = ask_split(q3)
        ask_runs(q4)
      end

      def ask_backlog(options)
        options.merge(backlog:
                      prompt.ask('How many tasks/tickets do you have left to complete?',
                                 required: true,
                                 convert: :int))
      end

      def ask_split(options)
        options.merge(split:
                      prompt.select('How certain are you with regard to the scope of the work?', CERTAINTY))
      end

      def ask_start(options)
        options.merge(start:
                      prompt.ask('When will you start work (e.g. 28/04/2021)') do |q|
                        q.required true
                        q.default Date.today
                        q.convert ->(input) { Date.parse(input.to_s) }
                      end)
      end

      def ask_throughput(options)
        data_exists = prompt.yes?('Do you have a JIRA csv export to use?', required: true)
        if data_exists
          path = prompt.ask('what is the absolute file path to the csv file', required: true)
          throughput = historic_throughput(path)
        else
          low = prompt.ask('Enter the smallest number of tasks/tickets you have finished in a week?', convert: :int)
          high = prompt.ask('Enter the largest number of tasks/tickets you have finished in a week?', convert: :int)
          throughput = (low..high).to_a
        end
        options.merge(throughput: throughput)
      end

      def ask_runs(options)
        options.merge(
          runs: prompt.select('How many simulations would you like to run?', RUNS)
        )
      end
    end
  end
end
