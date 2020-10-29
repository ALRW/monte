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
    map %w(--version -v) => :version

    desc 'carlo BACKLOG THROUGHPUT', 'Command description...'
    method_option :help, aliases: '-h', type: :boolean,
                         desc: 'Display usage information'
    def carlo(backlog, throughput)
      if options[:help]
        invoke :help, ['carlo']
      else
        require_relative 'commands/carlo'
        Monte::Commands::Carlo.new(backlog, throughput, options).execute
      end
    end
  end
end
