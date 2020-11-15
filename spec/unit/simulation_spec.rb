# frozen_string_literal: true

require 'monte/simulation'
require 'date'

class SUT; end

RSpec.describe Simulation do
  before(:each) do
    @args = {
      backlog: 20,
      split_factor: 1.2,
      runs: 1000,
      start_date: Date.parse('2020-10-10'),
      low: 2,
      high: 6
    }
    @sut = SUT.new
    @sut.extend(Simulation)
    allow_any_instance_of(Object).to receive(:rand).and_return(4)
  end

  it 'can produce a plausible estimate' do
    expect(@sut.simulate(@args[:backlog], @args[:low], @args[:high])).to eq(5)
  end

  it 'can produce thousands of these simulations' do
    result = @sut.run_simulations(@args)
    expect(result.length).to eq(@args[:runs])
    expect(result[0]).to eq(@args[:start_date] + 6 * 7)
  end
end
