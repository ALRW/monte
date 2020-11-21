# frozen_string_literal: true

# The code to run n monte carlo simulations
# args is a hash that must contain the following:
# :backlog
# :split_factor
# :runs
# :low
# :high
module Simulation
  PERCENTILES = [0.05, 0.15, 0.3, 0.5, 0.7, 0.85, 0.95].freeze

  def percentiles(options)
    results = run_simulations(options).sort
    PERCENTILES.map do |percentile|
      index = options[:runs] * (percentile - 1)
      results[index]
    end
  end

  def run_simulations(options)
    estimated_backlog = options[:backlog] * options[:split]
    Array.new(options[:runs]) do |_|
      options[:start] + simulate(
        estimated_backlog,
        options[:throughput]
      ) * 7
    end
  end

  def simulate(backlog, throughput, result = 0)
    return result if backlog <= 0

    simulate(
      backlog - throughput.sample,
      throughput,
      result + 1
    )
  end
end
