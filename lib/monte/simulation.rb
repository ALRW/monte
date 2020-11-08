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

  def percentiles(args)
    results = run_simulations(args).sort
    PERCENTILES.map do |percentile|
      index = args[:runs] * (percentile - 1)
      results[index]
    end
  end

  def run_simulations(args)
    estimated_backlog = args[:backlog] * args[:split_factor]
    Array.new(args[:runs]).map do |_|
      args[:start_date] + simulate(
        backlog: estimated_backlog,
        low: args[:low],
        high: args[:high]
      ) * 7
    end
  end

  def simulate(backlog:, low:, high:, result: 0)
    return result if backlog <= 0

    simulate(
      backlog: backlog - rand(low..high),
      low: low,
      high: high,
      result: result + 1
    )
  end
end
