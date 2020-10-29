# frozen_string_literal: true

require_relative '../command'

module Monte
  module Commands
    class Carlo < Monte::Command
      def initialize(backlog, throughput, options)
        @backlog = backlog
        @throughput = throughput
        @options = options
      end

      def execute(_: $stdin, output: $stdout)
        @number_of_weeks = @backlog.to_i / @throughput.to_i
        output.puts "It will take you #{@number_of_weeks} weeks to complete your work"
      end
    end
  end
end
