# frozen_string_literal: true

require 'thor'

module Monte
  # Handle the application command line parsing
  # and the dispatch to various command objects
  #
  # @api public
  class CLI < Thor
    # Error raised by this runner
    Error = Class.new(StandardError)

    desc 'version', 'monte version'
    def version
      require_relative 'version'
      puts "v#{Monte::VERSION}"
    end
    map %w[--version -v] => :version

    desc 'carlo', 'Runs through a set of questions to generate a forecast for project completion'
    method_option :help, aliases: '-h', type: :boolean,
                         desc: 'Display usage information'
    def carlo
      if options[:help]
        invoke :help, ['carlo']
      else
        require_relative 'commands/carlo'
        Monte::Commands::Carlo.new.execute
      end
    end
  end
end
