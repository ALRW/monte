# frozen_string_literal: true

require 'monte/commands/carlo'

RSpec.describe Monte::Commands::Carlo do
  it 'executes `carlo` command successfully' do
    args = {
      backlog: 20,
      split_factor: 1.2,
      runs: 1000,
      start_date: Date.parse('2020-10-10'),
      low: 2,
      high: 6
    }
    output = StringIO.new
    command = Monte::Commands::Carlo.new({})
    allow(command).to receive(:ask_questions!) { args }
    allow(command).to receive(:create_header) { "\nMonte\n" }
    allow(command).to receive(:create_table) do |rows|
      rows[0].to_s
    end
    command.execute(output: output)
    expect(output.string).to eq("\nMonte\nPlease answer the following:\n\n\n\nYour Results\n\n2020-11-14\n")
  end
end
