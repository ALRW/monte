# frozen_string_literal: true

require 'monte/csv_data'

class SUT; end

RSpec.describe CSVData do
  before(:each) do
    @sut = SUT.new
    @sut.extend(CSVData)
  end
  it 'given a csv it returns an array of weekly throughput' do
    expected = [3, 1, 1, 4, 6, 5, 4, 2, 2, 8, 6, 1, 3, 4, 6, 6, 1, 1, 11, 4, 5, 6, 7, 13, 4, 8, 2, 3, 7, 4, 14, 9, 1, 6, 2, 1, 3, 7, 3, 3, 1, 2, 3, 4, 7, 2, 3, 1, 1, 1]
    path = File.join(File.dirname(__FILE__), '..', 'test_data', 'data.csv')
    expect(@sut.historic_throughput(path)).to eq(expected)
  end
end
