# frozen_string_literal: true

require 'monte/csv_data'

class SUT; end

RSpec.describe CSVData do
  before(:each) do
    @sut = SUT.new
    @sut.extend(CSVData)
  end
  it 'given a csv it returns an array of weekly throughput' do
    expected = [1, 2]
    puts(File.join(File.dirname(__FILE__)))
    expect('OK').to eq('Not Implemented')
  end
end
