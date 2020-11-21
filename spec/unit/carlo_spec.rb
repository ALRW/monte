# frozen_string_literal: true

require 'monte/commands/carlo'

RSpec.describe Monte::Commands::Carlo do
  it 'executes `carlo` command successfully' do
    title = "\nMonte\n"
    args = {
      backlog: 20,
      split: 1.2,
      runs: 1000,
      start: Date.parse('2020-10-10'),
      throughput: [4, 4, 4]
    }
    result = "#{title}#{Monte::Commands::Carlo::BLURB}#{args[:start] + 6 * 7}\n"
    command = Monte::Commands::Carlo.new
    allow(command).to receive(:ask_questions) { args }
    allow(command).to receive(:create_header) { title }
    allow(command).to receive(:create_table) do |rows|
      rows[0].to_s
    end
    expect do
      command.execute
    end.to output(result).to_stdout
  end
end
