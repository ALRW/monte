# frozen_string_literal: true

require 'monte/commands/carlo'

RSpec.describe Monte::Commands::Carlo do
  it 'executes `carlo` command successfully' do
    title = "\nMonte\n"
    args = {
      backlog: 20,
      split_factor: 1.2,
      runs: 1000,
      start_date: Date.parse('2020-10-10'),
      low: 2,
      high: 6
    }
    output = StringIO.new
    result = "#{title}#{Monte::Commands::Carlo::BLURB}#{args[:start_date] + 5 * 7}\n"
    command = Monte::Commands::Carlo.new({})
    allow(command).to receive(:ask_questions!) { args }
    allow(command).to receive(:create_header) { title }
    allow(command).to receive(:create_table) do |rows|
      rows[0].to_s
    end
    command.execute(output: output)
    expect(output.string).to eq(result)
  end
end
