# frozen_string_literal: true

require 'monte/simulation'
require 'date'

class SUT; end

RSpec.describe Simulation do
  before(:each) do
    @options = {
      backlog: 20,
      split: 1.2,
      runs: 1000,
      start: Date.parse('2020-10-10'),
      throughput: [4, 4, 4]
    }
    @sut = SUT.new
    @sut.extend(Simulation)
  end

  it 'can produce a plausible estimate' do
    expect(@sut.simulate(@options[:backlog], @options[:throughput])).to eq(5)
  end

  it 'can produce thousands of these simulations' do
    result = @sut.run_simulations(@options)
    expect(result.length).to eq(@options[:runs])
    expect(result[0]).to eq(@options[:start] + 6 * 7)
  end
end
