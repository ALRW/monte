# frozen_string_literal: true

require 'monte/csv_data'

class SUT; end

RSpec.describe CSVData do
  it 'given a csv it returns an array of weekly throughput' do
    before(:each) do
      @sut = SUT.new
      @sut.extend(CSVData)
      expect('OK').to eq('Not Implemented')
    end
  end
end
